import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/db/app_database.dart';
import '../../../core/growth/growth_footer.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/phone.dart';
import '../domain/statement_filter.dart';
import 'statement_calculator.dart';

/// Service responsible for generating, printing, and sharing Arabic customer statement PDFs.
class PdfStatementService {
  pw.Font? _cairoFont;

  /// Loads the bundled Cairo font with Arabic shaping and RTL support.
  Future<pw.Font> _loadFont() async {
    if (_cairoFont != null) return _cairoFont!;
    final fontData = await rootBundle.load('assets/fonts/Cairo.ttf');
    _cairoFont = pw.Font.ttf(fontData);
    return _cairoFont!;
  }

  /// Builds a sanitized file name: `كشف_حساب_{name}_{yyyy-MM-dd}.pdf`.
  static String buildFileName(String customerName, {DateTime? date}) {
    final now = date ?? DateTime.now();
    final dateStr = DateFormat('yyyy-MM-dd').format(now);
    final sanitizedName = customerName
        .trim()
        .replaceAll(RegExp(r'[^\w\u0600-\u06FF]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
    return 'كشف_حساب_${sanitizedName}_$dateStr.pdf';
  }

  /// Generates the raw PDF bytes for a customer statement.
  Future<Uint8List> generatePdf({
    required Customer customer,
    required StatementResult statement,
    String shopName = 'كشكول',
    String? shopPhone,
    String? paymentInfo,
    StatementPageFormat pageFormat = StatementPageFormat.a4,
    String? shopCode,
    bool includeGrowthFooter = true,
  }) async {
    final font = await _loadFont();
    final pdf = pw.Document();

    final isA4 = pageFormat == StatementPageFormat.a4;
    final pdfFormat = isA4
        ? PdfPageFormat.a4
        : const PdfPageFormat(
            80 * PdfPageFormat.mm,
            double.infinity,
            marginAll: 4 * PdfPageFormat.mm,
          );

    final now = DateTime.now();
    final dateGenStr = DateFormat('yyyy/MM/dd · hh:mm a').format(now);
    final rowDateFmt = DateFormat('yyyy/MM/dd');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pdfFormat,
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(base: font, bold: font),
        margin: isA4
            ? const pw.EdgeInsets.all(32)
            : const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        build: (context) {
          return [
            // Header Section
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 12),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.grey300, width: 1.5),
                ),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            shopName,
                            style: pw.TextStyle(
                              fontSize: isA4 ? 20 : 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue900,
                            ),
                          ),
                          if (shopPhone != null && shopPhone.isNotEmpty)
                            pw.Text(
                              shopPhone,
                              style: const pw.TextStyle(
                                fontSize: 11,
                                color: PdfColors.grey700,
                              ),
                            ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'كشف حساب عميل',
                            style: pw.TextStyle(
                              fontSize: isA4 ? 18 : 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            dateGenStr,
                            style: const pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.grey600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),

                  // Customer details row
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey100,
                      borderRadius: pw.BorderRadius.circular(6),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'العميل: ${customer.name}',
                          style: pw.TextStyle(
                            fontSize: isA4 ? 13 : 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        if (customer.phone != null)
                          pw.Text(
                            'التليفون: ${PhoneUtils.formatDisplay(customer.phone)}',
                            style: const pw.TextStyle(fontSize: 11),
                          ),
                        pw.Text(
                          'الفترة: ${statement.periodDescription}',
                          style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 12),

            // Opening Balance notice if non-zero
            if (statement.openingBalancePiasters != 0) ...[
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                margin: const pw.EdgeInsets.only(bottom: 8),
                decoration: pw.BoxDecoration(
                  color: PdfColors.amber50,
                  borderRadius: pw.BorderRadius.circular(4),
                  border: pw.Border.all(color: PdfColors.amber200),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'رصيد ما قبل هذه الفترة:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
                    ),
                    pw.Text(
                      MoneyUtils.formatMoney(statement.openingBalancePiasters),
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                        color: statement.openingBalancePiasters > 0
                            ? PdfColors.red800
                            : PdfColors.green800,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Transactions Table
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.8),
              columnWidths: isA4
                  ? const {
                      0: pw.FlexColumnWidth(2.2), // التاريخ
                      1: pw.FlexColumnWidth(4.0), // البيان
                      2: pw.FlexColumnWidth(2.2), // عليه
                      3: pw.FlexColumnWidth(2.2), // دفع
                      4: pw.FlexColumnWidth(2.5), // الرصيد
                    }
                  : const {
                      0: pw.FlexColumnWidth(2.0),
                      1: pw.FlexColumnWidth(3.0),
                      2: pw.FlexColumnWidth(1.8),
                      3: pw.FlexColumnWidth(1.8),
                      4: pw.FlexColumnWidth(2.2),
                    },
              children: [
                // Table Header
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.blue50),
                  children: [
                    _cell('التاريخ', isHeader: true, fontSize: isA4 ? 11 : 9),
                    _cell('البيان', isHeader: true, fontSize: isA4 ? 11 : 9),
                    _cell('عليه', isHeader: true, color: PdfColors.red800, fontSize: isA4 ? 11 : 9),
                    _cell('دفع', isHeader: true, color: PdfColors.green800, fontSize: isA4 ? 11 : 9),
                    _cell('الرصيد', isHeader: true, fontSize: isA4 ? 11 : 9),
                  ],
                ),

                // Table Rows
                for (final row in statement.rows)
                  pw.TableRow(
                    children: [
                      _cell(rowDateFmt.format(row.transaction.occurredAt), fontSize: isA4 ? 10 : 8),
                      _cell(row.transaction.note ?? '—', fontSize: isA4 ? 10 : 8),
                      _cell(
                        row.debtPiasters > 0
                            ? MoneyUtils.formatMoney(row.debtPiasters, includeCurrency: false)
                            : '—',
                        color: row.debtPiasters > 0 ? PdfColors.red700 : PdfColors.black,
                        fontSize: isA4 ? 10 : 8,
                      ),
                      _cell(
                        row.paymentPiasters > 0
                            ? MoneyUtils.formatMoney(row.paymentPiasters, includeCurrency: false)
                            : '—',
                        color: row.paymentPiasters > 0 ? PdfColors.green700 : PdfColors.black,
                        fontSize: isA4 ? 10 : 8,
                      ),
                      _cell(
                        MoneyUtils.formatMoney(row.runningBalancePiasters, includeCurrency: false),
                        fontWeight: pw.FontWeight.bold,
                        color: row.runningBalancePiasters > 0
                            ? PdfColors.red800
                            : PdfColors.green800,
                        fontSize: isA4 ? 10 : 8,
                      ),
                    ],
                  ),
              ],
            ),
            pw.SizedBox(height: 14),

            // Summary Totals Box
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'إجمالي المشتريات / السلف: ${MoneyUtils.formatMoney(statement.periodDebitsPiasters)}',
                        style: const pw.TextStyle(fontSize: 11, color: PdfColors.red900),
                      ),
                      pw.Text(
                        'إجمالي المسدد: ${MoneyUtils.formatMoney(statement.periodCreditsPiasters)}',
                        style: const pw.TextStyle(fontSize: 11, color: PdfColors.green900),
                      ),
                    ],
                  ),
                  pw.Divider(color: PdfColors.grey300, height: 16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'الرصيد النهائي المطلوب:',
                        style: pw.TextStyle(
                          fontSize: isA4 ? 14 : 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        MoneyUtils.formatMoney(statement.finalBalancePiasters),
                        style: pw.TextStyle(
                          fontSize: isA4 ? 16 : 13,
                          fontWeight: pw.FontWeight.bold,
                          color: statement.finalBalancePiasters > 0
                              ? PdfColors.red800
                              : PdfColors.green800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Payment Information if available
            if (paymentInfo != null && paymentInfo.trim().isNotEmpty) ...[
              pw.SizedBox(height: 10),
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  color: PdfColors.blue50,
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Text(
                  'طرق الدفع المتاحة: ${paymentInfo.trim()}',
                  style: const pw.TextStyle(fontSize: 10, color: PdfColors.blue900),
                ),
              ),
            ],

            pw.SizedBox(height: 16),

            // Growth footer (Feature 11) — emoji omitted because Cairo has no emoji glyphs.
            if (includeGrowthFooter)
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'اتعمل بكشكول — جرّبه ببلاش:',
                      style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
                    ),
                    pw.SizedBox(height: 2),
                    pw.UrlLink(
                      destination: GrowthFooter.buildLink(shopCode),
                      child: pw.Text(
                        GrowthFooter.buildLink(shopCode),
                        textDirection: pw.TextDirection.ltr,
                        style: const pw.TextStyle(fontSize: 7, color: PdfColors.blue800),
                      ),
                    ),
                  ],
                ),
              ),
          ];
        },
      ),
    );

    return await pdf.save();
  }

  static pw.Widget _cell(
    String text, {
    bool isHeader = false,
    PdfColor? color,
    pw.FontWeight? fontWeight,
    double fontSize = 10,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
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

  /// Saves the PDF to temporary storage and triggers the native OS share sheet.
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

  /// Sends the PDF directly to a printer or print dialog.
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
