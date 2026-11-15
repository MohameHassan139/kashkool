import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/pdf/pdf_preview_screen.dart';
import '../../../core/pdf/pdf_reports_service.dart';
import '../../../core/utils/money.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/l10n.dart';
import '../../onboarding/data/shop_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../data/reports_repository.dart';
import '../domain/profit_loss_report.dart';

class ProfitLossScreen extends ConsumerWidget {
  const ProfitLossScreen({super.key});

  String _periodLabel(ReportPeriod period) {
    switch (period) {
      case ReportPeriod.today:
        return L10n.t.profitLossPeriodToday;
      case ReportPeriod.last7Days:
        return L10n.t.profitLossPeriodWeek;
      case ReportPeriod.thisMonth:
        return L10n.t.profitLossPeriodMonth;
      case ReportPeriod.allTime:
        return L10n.t.profitLossPeriodAll;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(profitLossReportStreamProvider);
    final selectedPeriod = ref.watch(selectedProfitLossPeriodProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.t.profitLossTitle),
        actions: [
          IconButton(
            tooltip: 'طباعة وتصدير PDF',
            icon: const Icon(Icons.picture_as_pdf_rounded),
            onPressed: () async {
              final report = reportAsync.value;
              if (report == null) return;
              final activeShop = ref.read(activeShopStreamProvider).value;
              final shopName = activeShop?.name ?? L10n.pdf.main1;
              final shopPhone = activeShop?.phone;
              final shopCode = await ref.read(settingsRepositoryProvider).getOrCreateShopCode();
              final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
              if (!context.mounted) return;
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PdfPreviewScreen(
                    title: 'تقرير الأرباح والخسائر',
                    fileName: 'تقرير_المكسب_والخسارة_$dateStr.pdf',
                    generator: (format) => ref.read(pdfReportsServiceProvider).generateProfitLossPdf(
                          report: report,
                          shopName: shopName,
                          shopPhone: shopPhone,
                          shopCode: shopCode,
                          format: format,
                        ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Period Selector Chips
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: ReportPeriod.values.map((period) {
                  final isSelected = selectedPeriod == period;
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: ChoiceChip(
                      selected: isSelected,
                      label: Text(_periodLabel(period)),
                      onSelected: (_) {
                        ref
                            .read(selectedProfitLossPeriodProvider.notifier)
                            .state = period;
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: reportAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('خطأ: $err')),
              data: (report) {
                final isNetPositive = report.netProfitPiasters >= 0;
                final isCashPositive = report.cashNetProfitPiasters >= 0;
                final netColor = isNetPositive
                    ? AppColors.paymentGreen
                    : AppColors.debtRed;
                final cashColor = isCashPositive
                    ? AppColors.paymentGreen
                    : AppColors.debtRed;
                const creditColor = Color(0xFFEA580C); // Warm Orange for receivables

                return LayoutBuilder(builder: (context, constraints) {
                  final isTablet = constraints.maxWidth >= 600;

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                    children: [
                      // Dual Highlight Cards: Cash vs Credit
                      if (isTablet)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildHighlightCard(
                                context,
                                isDark: isDark,
                                title: l10n.profitLossCashSectionTitle,
                                subtitle: l10n.profitLossCashSectionSubtitle,
                                amount: report.cashNetProfitPiasters,
                                color: cashColor,
                                icon: Icons.account_balance_wallet_rounded,
                                badgeText: 'نقدية فعلية بالدرج',
                                salesCount: report.cashSalesCount,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildHighlightCard(
                                context,
                                isDark: isDark,
                                title: l10n.profitLossCreditSectionTitle,
                                subtitle: l10n.profitLossCreditSectionSubtitle,
                                amount: report.creditGrossProfitPiasters,
                                color: creditColor,
                                icon: Icons.schedule_rounded,
                                badgeText: 'مؤجل عند الزبائن',
                                salesCount: report.creditSalesCount,
                              ),
                            ),
                          ],
                        )
                      else ...[
                        _buildHighlightCard(
                          context,
                          isDark: isDark,
                          title: l10n.profitLossCashSectionTitle,
                          subtitle: l10n.profitLossCashSectionSubtitle,
                          amount: report.cashNetProfitPiasters,
                          color: cashColor,
                          icon: Icons.account_balance_wallet_rounded,
                          badgeText: 'نقدية فعلية بالدرج',
                          salesCount: report.cashSalesCount,
                        ),
                        const SizedBox(height: 12),
                        _buildHighlightCard(
                          context,
                          isDark: isDark,
                          title: l10n.profitLossCreditSectionTitle,
                          subtitle: l10n.profitLossCreditSectionSubtitle,
                          amount: report.creditGrossProfitPiasters,
                          color: creditColor,
                          icon: Icons.schedule_rounded,
                          badgeText: 'مؤجل عند الزبائن',
                          salesCount: report.creditSalesCount,
                        ),
                      ],
                      const SizedBox(height: 16),

                      // Total Expected Net Profit Summary Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: netColor.withValues(alpha: 0.35),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      isNetPositive
                                          ? Icons.trending_up_rounded
                                          : Icons.trending_down_rounded,
                                      color: netColor,
                                      size: 26,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      l10n.profitLossTotalExpectedNet,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        color: netColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: netColor.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${l10n.profitLossMargin}: ${report.profitMarginPercentage.toStringAsFixed(1)}%',
                                    style: TextStyle(
                                      color: netColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              MoneyUtils.formatMoney(report.netProfitPiasters.abs()),
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: netColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'صافي الأرباح الكلي = صافي الكاش بالدرج (${MoneyUtils.formatMoney(report.cashNetProfitPiasters)}) + أرباح الآجل عند الزبائن (${MoneyUtils.formatMoney(report.creditGrossProfitPiasters)})',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? const Color(0xFF94A3B8)
                                    : const Color(0xFF64748B),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Section 1: Cash Breakdown Card
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: isDark
                                ? const Color(0xFF334155)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                        AppColors.paymentGreen.withValues(alpha: 0.15),
                                    child: const Icon(
                                      Icons.attach_money_rounded,
                                      size: 18,
                                      color: AppColors.paymentGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n.profitLossCashSectionTitle,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.paymentGreen,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 22),
                              _buildRow(
                                context,
                                icon: Icons.point_of_sale_rounded,
                                iconColor: AppColors.paymentGreen,
                                label: l10n.profitLossCashRevenue,
                                amount: report.cashRevenuePiasters,
                              ),
                              const SizedBox(height: 10),
                              _buildRow(
                                context,
                                icon: Icons.inventory_2_outlined,
                                iconColor: AppColors.neutralGrey,
                                label: l10n.profitLossCashCogs,
                                amount: report.cashCogsPiasters,
                                isNegative: true,
                              ),
                              const SizedBox(height: 10),
                              _buildRow(
                                context,
                                icon: Icons.calculate_outlined,
                                iconColor: theme.colorScheme.primary,
                                label: l10n.profitLossCashGross,
                                amount: report.cashGrossProfitPiasters,
                                isBold: true,
                              ),
                              const SizedBox(height: 10),
                              _buildRow(
                                context,
                                icon: Icons.receipt_long_rounded,
                                iconColor: AppColors.debtRed,
                                label: l10n.profitLossExpenses,
                                amount: report.operatingExpensesPiasters,
                                isNegative: true,
                              ),
                              const Divider(height: 22),
                              _buildRow(
                                context,
                                icon: Icons.account_balance_wallet_rounded,
                                iconColor: cashColor,
                                label: l10n.profitLossCashNet,
                                amount: report.cashNetProfitPiasters,
                                customColor: cashColor,
                                isBold: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Section 2: Credit Receivables Breakdown Card
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: isDark
                                ? const Color(0xFF334155)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                        creditColor.withValues(alpha: 0.15),
                                    child: const Icon(
                                      Icons.schedule_rounded,
                                      size: 18,
                                      color: creditColor,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n.profitLossCreditSectionTitle,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: creditColor,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 22),
                              _buildRow(
                                context,
                                icon: Icons.credit_score_rounded,
                                iconColor: creditColor,
                                label: l10n.profitLossCreditRevenue,
                                amount: report.creditRevenuePiasters,
                              ),
                              const SizedBox(height: 10),
                              _buildRow(
                                context,
                                icon: Icons.inventory_2_outlined,
                                iconColor: AppColors.neutralGrey,
                                label: l10n.profitLossCreditCogs,
                                amount: report.creditCogsPiasters,
                                isNegative: true,
                              ),
                              const Divider(height: 22),
                              _buildRow(
                                context,
                                icon: Icons.savings_outlined,
                                iconColor: creditColor,
                                label: l10n.profitLossCreditGross,
                                amount: report.creditGrossProfitPiasters,
                                customColor: creditColor,
                                isBold: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Educational Explanation Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF334155)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.lightbulb_outline_rounded,
                              size: 24,
                              color: Color(0xFFF59E0B),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'معلومة محاسبية تهمك في إدارة محلك',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: isDark
                                          ? const Color(0xFFF1F5F9)
                                          : const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '• الأرباح النقدية: هي السيولة الحقيقية التي دخلت درجك وخزنتك بالفعل بعد خصم المصروفات.\n• الأرباح الآجلة: هي أرباح بضاعة خرجت للزبائن شُكك ومسجلة في حساباتهم، وستتحول إلى سيولة في يدك فور سدادهم في التحصيل.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? const Color(0xFF94A3B8)
                                          : const Color(0xFF475569),
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(
    BuildContext context, {
    required bool isDark,
    required String title,
    required String subtitle,
    required int amount,
    required Color color,
    required IconData icon,
    required String badgeText,
    required int salesCount,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: color.withValues(alpha: 0.15),
                    child: Icon(icon, color: color, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            MoneyUtils.formatMoney(amount),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              height: 1.25,
            ),
          ),
          if (salesCount > 0) ...[
            const SizedBox(height: 6),
            Text(
              '($salesCount عملية بيع مسجلة)',
              style: TextStyle(
                fontSize: 10,
                color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required int amount,
    Color? customColor,
    bool isNegative = false,
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    final displayColor = customColor ??
        (isNegative ? AppColors.debtRed : theme.textTheme.bodyLarge?.color);

    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 14 : 13,
            ),
          ),
        ),
        Text(
          '${isNegative && amount > 0 ? "- " : ""}${MoneyUtils.formatMoney(amount.abs())}',
          style: TextStyle(
            color: displayColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            fontSize: isBold ? 15 : 13,
          ),
        ),
      ],
    );
  }
}
