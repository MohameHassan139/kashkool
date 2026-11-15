import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/inventory/domain/product_with_stock.dart';
import '../../features/reports/domain/profit_loss_report.dart';
import '../../features/reports/domain/shop_financial_overview.dart';
import '../../l10n/l10n.dart';
import '../db/app_database.dart';
import '../growth/growth_footer.dart';
import '../utils/money.dart';

/// Page format configuration for reports and receipts.
enum PdfDocumentFormat {
  a4,
  thermal80mm,
}

/// Centralized service for generating, printing, and sharing all PDF reports and invoices.
class PdfReportsService {
  pw.Font? _cairoFont;

  /// Loads the bundled Cairo font with Arabic shaping and RTL support.
  Future<pw.Font> _loadFont() async {
    if (_cairoFont != null) return _cairoFont!;
    try {
      final fontData = await rootBundle.load('assets/fonts/Cairo.ttf');
      _cairoFont = pw.Font.ttf(fontData);
      return _cairoFont!;
    } catch (_) {
      // Fallback for tests or environments where asset bundle isn't available
      return pw.Font.helvetica();
    }
  }

  static PdfPageFormat _pageFormatFor(PdfDocumentFormat format, {int itemCount = 1}) {
    if (format == PdfDocumentFormat.thermal80mm) {
      const thermalWidth = 80 * PdfPageFormat.mm;
      const thermalMarginAll = 4 * PdfPageFormat.mm;
      // Calculate a safe, realistic height in millimeters based on item count.
      // Base overhead: 150mm (header, metadata, totals, footer) + 14mm per item line.
      // Clamped between 160mm and 480mm so single pages never blow GPU texture limits on budget devices.
      final heightMm = (150.0 + (itemCount * 14.0)).clamp(160.0, 480.0);
      return PdfPageFormat(
        thermalWidth,
        heightMm * PdfPageFormat.mm,
        marginAll: thermalMarginAll,
      );
    }
    return PdfPageFormat.a4;
  }

  // ===========================================================================
  // 1. PROFIT & LOSS REPORT PDF
  // ===========================================================================

  Future<Uint8List> generateProfitLossPdf({
    required ProfitLossReport report,
    required String shopName,
    String? shopPhone,
    String? shopCode,
    PdfDocumentFormat format = PdfDocumentFormat.a4,
    bool includeGrowthFooter = true,
  }) async {
    final font = await _loadFont();
    final pdf = pw.Document();
    final isA4 = format == PdfDocumentFormat.a4;
    final pageFormat = _pageFormatFor(format, itemCount: 8);

    final now = DateTime.now();
    final genDateStr = DateFormat('yyyy/MM/dd · hh:mm a').format(now);
    final periodStartStr = DateFormat('yyyy/MM/dd').format(report.startDate);
    final periodEndStr = DateFormat('yyyy/MM/dd').format(report.endDate);

    String periodTitle;
    switch (report.period) {
      case ReportPeriod.today:
        periodTitle = 'اليوم ($periodEndStr)';
        break;
      case ReportPeriod.last7Days:
        periodTitle = 'آخر 7 أيام ($periodStartStr إلى $periodEndStr)';
        break;
      case ReportPeriod.thisMonth:
        periodTitle = 'هذا الشهر ($periodStartStr إلى $periodEndStr)';
        break;
      case ReportPeriod.allTime:
        periodTitle = 'كل الفترات (حتى $periodEndStr)';
        break;
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        textDirection: L10n.pdfIsRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
        theme: pw.ThemeData.withFont(base: font, bold: font),
        margin: isA4 ? const pw.EdgeInsets.all(32) : const pw.EdgeInsets.all(8),
        build: (context) {
          return [
            // Header
            _buildReportHeader(
              title: 'تقرير الأرباح والخسائر والتقفيل',
              subtitle: 'الفترة: $periodTitle',
              shopName: shopName,
              shopPhone: shopPhone,
              generatedAt: genDateStr,
              isA4: isA4,
            ),
            pw.SizedBox(height: isA4 ? 16 : 10),

            // Highlight Cards (Cash Realized vs Credit Receivables vs Net)
            pw.Container(
              padding: pw.EdgeInsets.all(isA4 ? 12 : 8),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      _metricBadge(
                        label: 'صافي الربح النقدي (بالدرج)',
                        value: MoneyUtils.formatMoney(report.cashNetProfitPiasters),
                        color: report.cashNetProfitPiasters >= 0 ? PdfColors.green800 : PdfColors.red800,
                        isA4: isA4,
                      ),
                      _metricBadge(
                        label: 'أرباح آجلة (عند العملاء)',
                        value: MoneyUtils.formatMoney(report.creditGrossProfitPiasters),
                        color: PdfColors.orange800,
                        isA4: isA4,
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Divider(color: PdfColors.grey300),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      _metricBadge(
                        label: 'إجمالي صافي أرباح المحل',
                        value: MoneyUtils.formatMoney(report.netProfitPiasters),
                        color: report.netProfitPiasters >= 0 ? PdfColors.green900 : PdfColors.red900,
                        isA4: isA4,
                        isLarge: true,
                      ),
                      _metricBadge(
                        label: 'إجمالي المبيعات (كاش + آجل)',
                        value: MoneyUtils.formatMoney(report.totalRevenuePiasters),
                        color: PdfColors.blue800,
                        isA4: isA4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: isA4 ? 18 : 12),

            // Section Title
            pw.Text(
              'مقارنة المبيعات النقدية والآجلة',
              style: pw.TextStyle(fontSize: isA4 ? 12 : 10, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 6),

            // Table: Cash vs Credit Breakdown
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.blue50),
                  children: [
                    _cell('البيان', isHeader: true, isA4: isA4),
                    _cell('مبيعات كاش (نقدي)', isHeader: true, isA4: isA4, color: PdfColors.green900),
                    _cell('مبيعات شكك (آجل)', isHeader: true, isA4: isA4, color: PdfColors.orange900),
                    _cell('الإجمالي الكلي', isHeader: true, isA4: isA4, color: PdfColors.blue900),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('إيرادات المبيعات', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.cashRevenuePiasters), isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.creditRevenuePiasters), isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.totalRevenuePiasters), fontWeight: pw.FontWeight.bold, isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('تكلفة البضاعة المباعة (شراء)', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.cashCogsPiasters), isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.creditCogsPiasters), isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.costOfGoodsSoldPiasters), isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _cell('مجمل الربح', fontWeight: pw.FontWeight.bold, isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.cashGrossProfitPiasters), color: PdfColors.green800, fontWeight: pw.FontWeight.bold, isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.creditGrossProfitPiasters), color: PdfColors.orange800, fontWeight: pw.FontWeight.bold, isA4: isA4),
                    _cell(MoneyUtils.formatMoney(report.grossProfitPiasters), fontWeight: pw.FontWeight.bold, isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('عدد عمليات البيع', isA4: isA4),
                    _cell('${report.cashSalesCount} فاتورة', isA4: isA4),
                    _cell('${report.creditSalesCount} فاتورة', isA4: isA4),
                    _cell('${report.totalSalesCount} فاتورة', fontWeight: pw.FontWeight.bold, isA4: isA4),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: isA4 ? 14 : 10),

            // Operating Expenses & Net Result Summary
            pw.Container(
              padding: pw.EdgeInsets.all(isA4 ? 10 : 8),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: PdfColors.grey200),
              ),
              child: pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'مصروفات تشغيلية (مخصومة من درج الكاش):',
                        style: pw.TextStyle(fontSize: isA4 ? 10 : 8),
                      ),
                      pw.Text(
                        '- ${MoneyUtils.formatMoney(report.operatingExpensesPiasters)} (${report.totalExpensesCount} حركة)',
                        style: pw.TextStyle(fontSize: isA4 ? 10 : 8, color: PdfColors.red800, fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 4),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'نسبة هامش الربح الكلي:',
                        style: pw.TextStyle(fontSize: isA4 ? 10 : 8),
                      ),
                      pw.Text(
                        '${report.profitMarginPercentage.toStringAsFixed(1)}%',
                        style: pw.TextStyle(fontSize: isA4 ? 10 : 8, fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 12),

            // Educational explanation
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                color: PdfColors.amber50,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: PdfColors.amber200),
              ),
              child: pw.Text(
                'تنبيه كشكول: صافي الربح النقدي يمثل الأموال الحقيقية التي دخلت درجك ومحفظتك بعد سداد التكلفة والمصروفات. الأرباح الآجلة هي أرباح بضاعة خرجت لعملاء الشكك وتتحول لكاش فعلي عند التحصيل.',
                style: pw.TextStyle(fontSize: isA4 ? 8.5 : 7, color: PdfColors.grey800),
              ),
            ),

            if (includeGrowthFooter) ...[
              pw.SizedBox(height: 16),
              _buildGrowthFooter(shopCode, isA4),
            ],
          ];
        },
      ),
    );

    return await pdf.save();
  }

  // ===========================================================================
  // 2. COMPREHENSIVE SHOP & VALUATION REPORT PDF
  // ===========================================================================

  Future<Uint8List> generateShopOverviewPdf({
    required ShopFinancialOverview overview,
    required String shopName,
    String? shopPhone,
    String? shopCode,
    PdfDocumentFormat format = PdfDocumentFormat.a4,
    bool includeGrowthFooter = true,
  }) async {
    final font = await _loadFont();
    final pdf = pw.Document();
    final isA4 = format == PdfDocumentFormat.a4;
    final pageFormat = _pageFormatFor(format, itemCount: 10);

    final genDateStr = DateFormat('yyyy/MM/dd · hh:mm a').format(overview.generatedAt);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        textDirection: L10n.pdfIsRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
        theme: pw.ThemeData.withFont(base: font, bold: font),
        margin: isA4 ? const pw.EdgeInsets.all(32) : const pw.EdgeInsets.all(8),
        build: (context) {
          return [
            _buildReportHeader(
              title: 'تقرير المحل المالي الشامل ورأس المال',
              subtitle: 'جرد شامل للمخزون والديون والسيولة النقدية',
              shopName: shopName,
              shopPhone: shopPhone,
              generatedAt: genDateStr,
              isA4: isA4,
            ),
            pw.SizedBox(height: isA4 ? 16 : 10),

            // Big Highlight Banner: Net Worth
            pw.Container(
              padding: pw.EdgeInsets.all(isA4 ? 14 : 10),
              decoration: pw.BoxDecoration(
                color: PdfColors.teal50,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: PdfColors.teal300, width: 1.5),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Text(
                    'صافي رأس مال المحل (Shop Net Worth)',
                    style: pw.TextStyle(fontSize: isA4 ? 12 : 9, color: PdfColors.teal900, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    MoneyUtils.formatMoney(overview.netWorthPiasters),
                    style: pw.TextStyle(fontSize: isA4 ? 20 : 16, color: PdfColors.teal900, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    '= (بضاعة المخزن بالتكلفة + النقدية بالدرج والبنك + لينا عند الزباين) - ديون الموردين',
                    style: pw.TextStyle(fontSize: isA4 ? 8.5 : 7, color: PdfColors.grey700),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: isA4 ? 16 : 10),

            // Section 1: Inventory Valuation
            _sectionHeader('1. بضاعة المخزن والمستودع', isA4),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _cell('البيان', isHeader: true, isA4: isA4),
                    _cell('القيمة / العدد', isHeader: true, isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('قيمة البضاعة بسعر الشراء (التكلفة)', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(overview.inventoryCostPiasters), fontWeight: pw.FontWeight.bold, isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('قيمة البضاعة بسعر البيع (المتوقع)', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(overview.inventoryRetailPiasters), isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('الربح المتوقع عند بيع كامل المخزون', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(overview.inventoryExpectedProfitPiasters), color: PdfColors.green800, fontWeight: pw.FontWeight.bold, isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('إجمالي الأصناف بالمحل', isA4: isA4),
                    _cell('${overview.totalProductCount} صنف (نواقص بحاجة لطلب: ${overview.lowStockCount})', isA4: isA4),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: isA4 ? 14 : 10),

            // Section 2: Receivables & Payables
            _sectionHeader('2. الديون والمستحقات (العملاء والموردين)', isA4),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _cell('الطرف', isHeader: true, isA4: isA4),
                    _cell('المبلغ', isHeader: true, isA4: isA4),
                    _cell('العدد', isHeader: true, isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('لينا عند العملاء (ديون شكك)', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(overview.customerReceivablesPiasters), color: PdfColors.green800, fontWeight: pw.FontWeight.bold, isA4: isA4),
                    _cell('${overview.customerDebtCount} عميل', isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('علينا للموردين (مستحقات بضاعة)', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(overview.supplierPayablesPiasters), color: PdfColors.red800, fontWeight: pw.FontWeight.bold, isA4: isA4),
                    _cell('${overview.supplierDebtCount} مورد', isA4: isA4),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: isA4 ? 14 : 10),

            // Section 3: Cash & Digital Balance
            _sectionHeader('3. السيولة والنقدية المتاحة', isA4),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _cell('الخزينة / المصدر', isHeader: true, isA4: isA4),
                    _cell('المبلغ المتاح', isHeader: true, isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('كاش بالدرج (الخزينة النقدية)', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(overview.cashInDrawerPiasters), isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _cell('رصيد إلكتروني (إنستاباي / فودافون كاش / بنك)', isA4: isA4),
                    _cell(MoneyUtils.formatMoney(overview.digitalBalancePiasters), isA4: isA4),
                  ],
                ),
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _cell('إجمالي النقدية المتاحة', fontWeight: pw.FontWeight.bold, isA4: isA4),
                    _cell(MoneyUtils.formatMoney(overview.totalCashAndBankPiasters), fontWeight: pw.FontWeight.bold, isA4: isA4),
                  ],
                ),
              ],
            ),

            if (includeGrowthFooter) ...[
              pw.SizedBox(height: 18),
              _buildGrowthFooter(shopCode, isA4),
            ],
          ];
        },
      ),
    );

    return await pdf.save();
  }

  // ===========================================================================
  // 3. INVENTORY & LOW STOCK REPORT PDF
  // ===========================================================================

  Future<Uint8List> generateInventoryReportPdf({
    required List<ProductWithStock> products,
    required String shopName,
    String? shopPhone,
    String? shopCode,
    bool isLowStockOnly = false,
    PdfDocumentFormat format = PdfDocumentFormat.a4,
    bool includeGrowthFooter = true,
  }) async {
    final font = await _loadFont();
    final pdf = pw.Document();
    final isA4 = format == PdfDocumentFormat.a4;
    final pageFormat = _pageFormatFor(format, itemCount: products.length);

    final genDateStr = DateFormat('yyyy/MM/dd · hh:mm a').format(DateTime.now());
    final title = isLowStockOnly ? 'كشف النواقص وطلبيات الموردين' : 'تقرير جرد المخزون العام وقيمة البضاعة';
    final subtitle = isLowStockOnly
        ? 'الأصناف التي وصلت للحد الأدنى وبحاجة لإعادة طلب'
        : 'بيان كامل بجميع الأصناف والكميات وأسعار التكلفة والبيع';

    // Summary calculations
    final totalCostPiasters = products.fold<int>(
      0,
      (sum, p) => sum + ((p.quantityMilliUnits * p.product.purchasePricePiasters + 500) ~/ 1000),
    );
    final lowStockCount = products.where((p) => p.isLowStock).length;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        textDirection: L10n.pdfIsRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
        theme: pw.ThemeData.withFont(base: font, bold: font),
        margin: isA4 ? const pw.EdgeInsets.all(32) : const pw.EdgeInsets.all(8),
        build: (context) {
          return [
            _buildReportHeader(
              title: title,
              subtitle: subtitle,
              shopName: shopName,
              shopPhone: shopPhone,
              generatedAt: genDateStr,
              isA4: isA4,
            ),
            pw.SizedBox(height: isA4 ? 14 : 8),

            // Stats row
            pw.Container(
              padding: pw.EdgeInsets.symmetric(horizontal: isA4 ? 12 : 8, vertical: 8),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('عدد الأصناف: ${products.length}', style: pw.TextStyle(fontSize: isA4 ? 10 : 8, fontWeight: pw.FontWeight.bold)),
                  pw.Text('النواقص: $lowStockCount', style: pw.TextStyle(fontSize: isA4 ? 10 : 8, color: PdfColors.red800, fontWeight: pw.FontWeight.bold)),
                  if (!isLowStockOnly)
                    pw.Text('إجمالي القيمة بالتكلفة: ${MoneyUtils.formatMoney(totalCostPiasters)}', style: pw.TextStyle(fontSize: isA4 ? 10 : 8, fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ),
            pw.SizedBox(height: isA4 ? 14 : 8),

            // Products Table
            if (isLowStockOnly)
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.red50),
                    children: [
                      _cell('م', isHeader: true, isA4: isA4),
                      _cell('الصنف', isHeader: true, isA4: isA4),
                      _cell('الرصيد', isHeader: true, isA4: isA4),
                      _cell('الحد الأدنى', isHeader: true, isA4: isA4),
                      _cell('المورد', isHeader: true, isA4: isA4),
                      _cell('تليفون المورد', isHeader: true, isA4: isA4),
                      _cell('سعر الشراء', isHeader: true, isA4: isA4),
                    ],
                  ),
                  for (int i = 0; i < products.length; i++) ...[
                    pw.TableRow(
                      children: [
                        _cell('${i + 1}', isA4: isA4),
                        _cell(products[i].product.name, isA4: isA4, fontWeight: pw.FontWeight.bold),
                        _cell(
                          '${(products[i].quantityMilliUnits / 1000).toStringAsFixed(1)} ${products[i].product.unitLabel}',
                          color: PdfColors.red800,
                          fontWeight: pw.FontWeight.bold,
                          isA4: isA4,
                        ),
                        _cell('${(products[i].product.minimumStockMilliUnits / 1000).toStringAsFixed(1)} ${products[i].product.unitLabel}', isA4: isA4),
                        _cell(products[i].supplier?.name ?? '—', isA4: isA4),
                        _cell(products[i].supplier?.phone ?? '—', isA4: isA4),
                        _cell(MoneyUtils.formatMoney(products[i].product.purchasePricePiasters), isA4: isA4),
                      ],
                    ),
                  ],
                ],
              )
            else
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.blue50),
                    children: [
                      _cell('م', isHeader: true, isA4: isA4),
                      _cell('الصنف', isHeader: true, isA4: isA4),
                      _cell('الرصيد', isHeader: true, isA4: isA4),
                      _cell('سعر الشراء', isHeader: true, isA4: isA4),
                      _cell('سعر البيع', isHeader: true, isA4: isA4),
                      _cell('إجمالي التكلفة', isHeader: true, isA4: isA4),
                      _cell('الحالة', isHeader: true, isA4: isA4),
                    ],
                  ),
                  for (int i = 0; i < products.length; i++) ...[
                    pw.TableRow(
                      decoration: products[i].isLowStock ? const pw.BoxDecoration(color: PdfColors.red50) : null,
                      children: [
                        _cell('${i + 1}', isA4: isA4),
                        _cell(products[i].product.name, isA4: isA4, fontWeight: pw.FontWeight.bold),
                        _cell('${(products[i].quantityMilliUnits / 1000).toStringAsFixed(1)} ${products[i].product.unitLabel}', isA4: isA4),
                        _cell(MoneyUtils.formatMoney(products[i].product.purchasePricePiasters), isA4: isA4),
                        _cell(MoneyUtils.formatMoney(products[i].product.salePricePiasters), isA4: isA4),
                        _cell(
                          MoneyUtils.formatMoney(
                            ((products[i].quantityMilliUnits * products[i].product.purchasePricePiasters + 500) ~/ 1000),
                          ),
                          isA4: isA4,
                        ),
                        _cell(
                          products[i].isLowStock ? 'نواقص (عجز)' : 'متوفر',
                          color: products[i].isLowStock ? PdfColors.red800 : PdfColors.green800,
                          isA4: isA4,
                        ),
                      ],
                    ),
                  ],
                ],
              ),

            if (includeGrowthFooter) ...[
              pw.SizedBox(height: 18),
              _buildGrowthFooter(shopCode, isA4),
            ],
          ];
        },
      ),
    );

    return await pdf.save();
  }

  // ===========================================================================
  // 4. SALE INVOICE / RECEIPT PDF
  // ===========================================================================

  Future<Uint8List> generateSaleInvoicePdf({
    required Sale sale,
    required List<SaleItem> items,
    Customer? customer,
    required String shopName,
    String? shopPhone,
    String? shopAddress,
    String? shopCode,
    PdfDocumentFormat format = PdfDocumentFormat.thermal80mm,
    bool includeGrowthFooter = true,
  }) async {
    final font = await _loadFont();
    final pdf = pw.Document();
    final isA4 = format == PdfDocumentFormat.a4;

    final saleDateStr = DateFormat('yyyy/MM/dd · hh:mm a').format(sale.occurredAt.toLocal());
    final isCredit = sale.paymentType == SalePaymentType.credit;
    final shortSaleId = sale.id.length >= 8 ? sale.id.substring(0, 8).toUpperCase() : sale.id;

    final pageFormat = _pageFormatFor(format, itemCount: items.length);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        textDirection: L10n.pdfIsRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
        theme: pw.ThemeData.withFont(base: font, bold: font),
        margin: isA4 ? const pw.EdgeInsets.all(32) : const pw.EdgeInsets.all(6),
        build: (context) {
          return [
            // Shop Header
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    shopName,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontSize: isA4 ? 18 : 14, fontWeight: pw.FontWeight.bold),
                  ),
                  if (shopPhone != null && shopPhone.isNotEmpty) ...[
                    pw.SizedBox(height: 2),
                    pw.Text(
                      'هاتف: $shopPhone',
                      style: pw.TextStyle(fontSize: isA4 ? 10 : 8, color: PdfColors.grey700),
                    ),
                  ],
                  if (shopAddress != null && shopAddress.isNotEmpty) ...[
                    pw.SizedBox(height: 2),
                    pw.Text(
                      shopAddress,
                      style: pw.TextStyle(fontSize: isA4 ? 10 : 8, color: PdfColors.grey700),
                    ),
                  ],
                  pw.SizedBox(height: 6),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: pw.BoxDecoration(
                      color: isCredit ? PdfColors.orange100 : PdfColors.green100,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      isCredit ? 'فاتورة بيع آجل (شكك)' : 'فاتورة بيع نقدي (كاش)',
                      style: pw.TextStyle(
                        fontSize: isA4 ? 11 : 9,
                        color: isCredit ? PdfColors.orange900 : PdfColors.green900,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Divider(color: PdfColors.grey400, thickness: 1),

            // Metadata: Invoice No, Date, Customer
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('رقم الفاتورة: #$shortSaleId', style: pw.TextStyle(fontSize: isA4 ? 10 : 8)),
                pw.Text(saleDateStr, style: pw.TextStyle(fontSize: isA4 ? 10 : 8)),
              ],
            ),
            if (customer != null) ...[
              pw.SizedBox(height: 3),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('العميل: ${customer.name}', style: pw.TextStyle(fontSize: isA4 ? 10 : 8, fontWeight: pw.FontWeight.bold)),
                  if (customer.phone != null && customer.phone!.isNotEmpty)
                    pw.Text('هاتف: ${customer.phone}', style: pw.TextStyle(fontSize: isA4 ? 10 : 8)),
                ],
              ),
            ],
            pw.SizedBox(height: 8),

            // Items Table
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              columnWidths: isA4
                  ? const {
                      0: pw.FlexColumnWidth(3.5),
                      1: pw.FlexColumnWidth(1.5),
                      2: pw.FlexColumnWidth(1.5),
                      3: pw.FlexColumnWidth(1.8),
                    }
                  : const {
                      0: pw.FlexColumnWidth(3.0),
                      1: pw.FlexColumnWidth(1.6),
                      2: pw.FlexColumnWidth(1.6),
                      3: pw.FlexColumnWidth(1.8),
                    },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _cell('الصنف', isHeader: true, isA4: isA4),
                    _cell('الكمية', isHeader: true, isA4: isA4),
                    _cell('السعر', isHeader: true, isA4: isA4),
                    _cell('الإجمالي', isHeader: true, isA4: isA4),
                  ],
                ),
                for (final item in items)
                  pw.TableRow(
                    children: [
                      _cell(item.productName, isA4: isA4),
                      _cell('${(item.quantityMilliUnits / 1000).toStringAsFixed(1)} ${item.unitLabel}', isA4: isA4),
                      _cell(MoneyUtils.formatMoney(item.unitPricePiasters, includeCurrency: false), isA4: isA4),
                      _cell(MoneyUtils.formatMoney(item.lineTotalPiasters, includeCurrency: false), fontWeight: pw.FontWeight.bold, isA4: isA4),
                    ],
                  ),
              ],
            ),
            pw.SizedBox(height: 8),

            // Total Block
            pw.Container(
              padding: pw.EdgeInsets.all(isA4 ? 10 : 6),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('إجمالي الفاتورة:', style: pw.TextStyle(fontSize: isA4 ? 12 : 10, fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                        MoneyUtils.formatMoney(sale.totalPiasters),
                        style: pw.TextStyle(fontSize: isA4 ? 13 : 11, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 4),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('طريقة السداد:', style: pw.TextStyle(fontSize: isA4 ? 10 : 8)),
                      pw.Text(
                        isCredit ? 'آجل على حساب العميل' : 'كاش نقداً بالدرج',
                        style: pw.TextStyle(fontSize: isA4 ? 10 : 8, fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 10),

            // Thank you message
            pw.Center(
              child: pw.Text(
                'شكراً لزيارتكم ونسعد بخدمتكم دائماً',
                style: pw.TextStyle(fontSize: isA4 ? 9 : 7.5, color: PdfColors.grey700),
              ),
            ),

            if (includeGrowthFooter) ...[
              pw.SizedBox(height: 12),
              _buildGrowthFooter(shopCode, isA4),
            ],
          ];
        },
      ),
    );

    return await pdf.save();
  }

  // ===========================================================================
  // COMMON WIDGET HELPERS
  // ===========================================================================

  static pw.Widget _buildReportHeader({
    required String title,
    required String subtitle,
    required String shopName,
    String? shopPhone,
    required String generatedAt,
    required bool isA4,
  }) {
    return pw.Container(
      padding: pw.EdgeInsets.only(bottom: isA4 ? 12 : 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey300, width: 1.5),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(fontSize: isA4 ? 15 : 11, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                subtitle,
                style: pw.TextStyle(fontSize: isA4 ? 9.5 : 7.5, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                'تاريخ التقرير: $generatedAt',
                style: pw.TextStyle(fontSize: isA4 ? 8.5 : 7, color: PdfColors.grey600),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                shopName,
                style: pw.TextStyle(fontSize: isA4 ? 13 : 10, fontWeight: pw.FontWeight.bold),
              ),
              if (shopPhone != null && shopPhone.isNotEmpty) ...[
                pw.SizedBox(height: 2),
                pw.Text(
                  shopPhone,
                  style: pw.TextStyle(fontSize: isA4 ? 9 : 7, color: PdfColors.grey700),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _metricBadge({
    required String label,
    required String value,
    required PdfColor color,
    required bool isA4,
    bool isLarge = false,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontSize: isA4 ? 9.5 : 7.5, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: isLarge ? (isA4 ? 15 : 12) : (isA4 ? 12 : 9.5),
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  static pw.Widget _sectionHeader(String title, bool isA4) {
    return pw.Text(
      title,
      style: pw.TextStyle(
        fontSize: isA4 ? 11.5 : 9.5,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.blue900,
      ),
    );
  }

  static pw.Widget _cell(
    String text, {
    bool isHeader = false,
    PdfColor? color,
    pw.FontWeight? fontWeight,
    required bool isA4,
  }) {
    final fontSize = isA4 ? (isHeader ? 9.5 : 8.5) : (isHeader ? 7.5 : 7.0);
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: isA4 ? 6 : 4, vertical: isA4 ? 5 : 3),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: fontSize,
          fontWeight: isHeader ? pw.FontWeight.bold : (fontWeight ?? pw.FontWeight.normal),
          color: color ?? PdfColors.black,
        ),
      ),
    );
  }

  static pw.Widget _buildGrowthFooter(String? shopCode, bool isA4) {
    final link = GrowthFooter.buildLink(shopCode);
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300, width: 0.5)),
      ),
      child: pw.Center(
        child: pw.Column(
          children: [
            pw.Text(
              'اتعمل بكشكول — التطبيق الأسهل لحسابات المحلات في مصر',
              style: pw.TextStyle(fontSize: isA4 ? 8 : 6.5, color: PdfColors.grey600),
            ),
            pw.SizedBox(height: 2),
            pw.UrlLink(
              destination: link,
              child: pw.Text(
                link,
                textDirection: pw.TextDirection.ltr,
                style: pw.TextStyle(fontSize: isA4 ? 7.5 : 6, color: PdfColors.blue800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PRINT & SHARE HELPERS
  // ===========================================================================

  Future<void> sharePdf({
    required Uint8List bytes,
    required String fileName,
    String? subject,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(bytes);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/pdf', name: fileName)],
        subject: subject,
      ),
    );
  }

  Future<void> printPdf({
    required Uint8List bytes,
    required String name,
  }) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
      name: name,
    );
  }
}

final pdfReportsServiceProvider = Provider<PdfReportsService>((ref) {
  return PdfReportsService();
});
