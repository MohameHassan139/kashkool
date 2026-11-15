import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/pdf/pdf_preview_screen.dart';
import '../../../core/pdf/pdf_reports_service.dart';
import '../../../core/utils/money.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../../onboarding/data/shop_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../data/reports_repository.dart';
import '../domain/shop_financial_overview.dart';

class ShopFinancialReportScreen extends ConsumerWidget {
  const ShopFinancialReportScreen({super.key});

  String _buildReportText(String shopName, ShopFinancialOverview overview) {
    final buffer = StringBuffer();
    final dateStr = DateFormat('yyyy/MM/dd - hh:mm a').format(overview.generatedAt);

    buffer.writeln('📊 تقرير المحل المالي الشامل');
    if (shopName.isNotEmpty) {
      buffer.writeln('🏪 محل: $shopName');
    }
    buffer.writeln('🕒 التاريخ: $dateStr');
    buffer.writeln('---------------------------');
    buffer.writeln('💰 صافي رأس مال المحل: ${MoneyUtils.formatMoney(overview.netWorthPiasters)}');
    buffer.writeln();
    buffer.writeln('📦 بضاعة المخزن:');
    buffer.writeln('• بسعر الشراء (التكلفة): ${MoneyUtils.formatMoney(overview.inventoryCostPiasters)}');
    buffer.writeln('• بسعر البيع (المتوقع): ${MoneyUtils.formatMoney(overview.inventoryRetailPiasters)}');
    buffer.writeln('• الربح المتوقع: ${MoneyUtils.formatMoney(overview.inventoryExpectedProfitPiasters)}');
    buffer.writeln('• إجمالي الأصناف: ${overview.totalProductCount} (نواقص: ${overview.lowStockCount})');
    buffer.writeln();
    buffer.writeln('👥 لينا عند الزباين (ديون): ${MoneyUtils.formatMoney(overview.customerReceivablesPiasters)} (${overview.customerDebtCount} عميل)');
    buffer.writeln('🚚 علينا للموردين (ديون): ${MoneyUtils.formatMoney(overview.supplierPayablesPiasters)} (${overview.supplierDebtCount} مورد)');
    buffer.writeln();
    buffer.writeln('💵 النقدية المتاحة:');
    buffer.writeln('• كاش بالدرج: ${MoneyUtils.formatMoney(overview.cashInDrawerPiasters)}');
    buffer.writeln('• رصيد إلكتروني (إنستاباي/محافظ): ${MoneyUtils.formatMoney(overview.digitalBalancePiasters)}');
    buffer.writeln('• إجمالي الفلوس بالدرج والبنك: ${MoneyUtils.formatMoney(overview.totalCashAndBankPiasters)}');
    buffer.writeln('---------------------------');
    buffer.writeln('تم استخراج التقرير بواسطة كشكول 📒');
    return buffer.toString();
  }

  Future<void> _shareReport(
      BuildContext context, String shopName, ShopFinancialOverview overview) async {
    final text = _buildReportText(shopName, overview);
    final encoded = Uri.encodeComponent(text);
    final uri = Uri.parse('https://wa.me/?text=$encoded');

    try {
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (launched) return;
    } catch (_) {}

    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      AppGlassToast.showSuccess(
        context,
        'تم نسخ ملخص التقرير للحافظة بنجاح',
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(shopOverviewStreamProvider);
    final activeShopAsync = ref.watch(activeShopStreamProvider);
    final shopName = activeShopAsync.value?.name ?? '';
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.t.shopReportTitle),
        actions: [
          overviewAsync.maybeWhen(
            data: (overview) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.picture_as_pdf_rounded),
                  tooltip: 'طباعة وتصدير PDF',
                  onPressed: () async {
                    final shopPhone = activeShopAsync.value?.phone;
                    final shopCode = await ref.read(settingsRepositoryProvider).getOrCreateShopCode();
                    final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
                    if (!context.mounted) return;
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PdfPreviewScreen(
                          title: 'تقرير المحل الشامل',
                          fileName: 'تقرير_المحل_الشامل_$dateStr.pdf',
                          generator: (format) => ref.read(pdfReportsServiceProvider).generateShopOverviewPdf(
                                overview: overview,
                                shopName: shopName.isNotEmpty ? shopName : L10n.pdf.main1,
                                shopPhone: shopPhone,
                                shopCode: shopCode,
                                format: format,
                              ),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share_rounded),
                  tooltip: L10n.t.shopReportShare,
                  onPressed: () => _shareReport(context, shopName, overview),
                ),
              ],
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: overviewAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('خطأ: $err')),
        data: (overview) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Shop Net Worth Highlight
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF1E3A8A), const Color(0xFF1E293B)]
                        : [const Color(0xFF2563EB), const Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      L10n.t.shopReportNetWorth,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      MoneyUtils.formatMoney(overview.netWorthPiasters),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '(بضاعة المخزن + الفلوس بالدرج + ديون الزباين) - ديون الموردين',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 1. Inventory Valuation Card
              _buildSectionCard(
                context,
                title: L10n.t.shopReportInventoryValue,
                icon: Icons.inventory_2_outlined,
                iconColor: theme.colorScheme.primary,
                rows: [
                  _InfoRow(
                    label: L10n.t.shopReportAtCost,
                    value: MoneyUtils.formatMoney(overview.inventoryCostPiasters),
                  ),
                  _InfoRow(
                    label: L10n.t.shopReportAtRetail,
                    value: MoneyUtils.formatMoney(overview.inventoryRetailPiasters),
                  ),
                  _InfoRow(
                    label: L10n.t.shopReportExpectedProfit,
                    value: MoneyUtils.formatMoney(overview.inventoryExpectedProfitPiasters),
                    color: AppColors.paymentGreen,
                    isBold: true,
                  ),
                  _InfoRow(
                    label: L10n.t.shopReportLowStockCount,
                    value: '${overview.lowStockCount} من أصل ${overview.totalProductCount}',
                    color: overview.lowStockCount > 0 ? AppColors.debtRed : null,
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 2. Receivables Card ("لينا برة")
              _buildSectionCard(
                context,
                title: L10n.t.shopReportReceivables,
                icon: Icons.people_outline_rounded,
                iconColor: AppColors.paymentGreen,
                rows: [
                  _InfoRow(
                    label: 'إجمالي المبالغ المطلوبة من العملاء',
                    value: MoneyUtils.formatMoney(overview.customerReceivablesPiasters),
                    color: AppColors.paymentGreen,
                    isBold: true,
                  ),
                  _InfoRow(
                    label: 'عدد العملاء الذين عليهم مبالغ',
                    value: '${overview.customerDebtCount} عميل',
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 3. Payables Card ("علينا للموردين")
              _buildSectionCard(
                context,
                title: L10n.t.shopReportPayables,
                icon: Icons.local_shipping_outlined,
                iconColor: AppColors.debtRed,
                rows: [
                  _InfoRow(
                    label: 'إجمالي المستحق عليك للموردين',
                    value: MoneyUtils.formatMoney(overview.supplierPayablesPiasters),
                    color: AppColors.debtRed,
                    isBold: true,
                  ),
                  _InfoRow(
                    label: 'عدد الموردين المستحق لهم',
                    value: '${overview.supplierDebtCount} مورد',
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 4. Cash Drawer & Bank
              _buildSectionCard(
                context,
                title: L10n.t.shopReportCashDrawer,
                icon: Icons.account_balance_wallet_outlined,
                iconColor: const Color(0xFFF59E0B),
                rows: [
                  _InfoRow(
                    label: 'كاش في درج المحل',
                    value: MoneyUtils.formatMoney(overview.cashInDrawerPiasters),
                  ),
                  _InfoRow(
                    label: 'رصيد محافظ وإنستاباي',
                    value: MoneyUtils.formatMoney(overview.digitalBalancePiasters),
                  ),
                  _InfoRow(
                    label: 'إجمالي النقدية',
                    value: MoneyUtils.formatMoney(overview.totalCashAndBankPiasters),
                    color: const Color(0xFFF59E0B),
                    isBold: true,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => _shareReport(context, shopName, overview),
                icon: const Icon(Icons.share_rounded),
                label: Text(
                  L10n.t.shopReportShare,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<_InfoRow> rows,
  }) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: iconColor.withValues(alpha: 0.15),
                  child: Icon(icon, size: 18, color: iconColor),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    rows[i].label,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.neutralGrey,
                      fontWeight: rows[i].isBold
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  Text(
                    rows[i].value,
                    style: TextStyle(
                      fontSize: 14,
                      color: rows[i].color,
                      fontWeight: rows[i].isBold
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  final Color? color;
  final bool isBold;

  const _InfoRow({
    required this.label,
    required this.value,
    this.color,
    this.isBold = false,
  });
}
