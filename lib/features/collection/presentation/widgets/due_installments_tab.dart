import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/whatsapp_template.dart';
import '../../../installments/domain/due_installment_item.dart';
import '../../../installments/presentation/installment_plan_details_screen.dart';
import '../../../installments/presentation/installments_providers.dart';
import '../../../installments/presentation/widgets/pay_installment_dialog.dart';
import '../../../settings/data/settings_repository.dart';

/// Tab displaying installments due today or overdue for quick collection.
class DueInstallmentsTab extends ConsumerWidget {
  const DueInstallmentsTab({super.key});

  Future<void> _callCustomer(String phone) async {
    final uri = Uri.parse('tel:$phone');
    try {
      await launchUrl(uri);
    } catch (_) {}
  }

  Future<void> _sendWhatsAppReminder({
    required BuildContext context,
    required WidgetRef ref,
    required DueInstallmentItem item,
  }) async {
    if (item.customer.phone == null || item.customer.phone!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('العميل ليس لديه رقم تليفون مسجل')),
      );
      return;
    }

    final settingsRepo = ref.read(settingsRepositoryProvider);
    final shopName = await settingsRepo.getShopName();
    final shopCode = await settingsRepo.getOrCreateShopCode();
    final phoneNum = await settingsRepo.getShopPhone();
    final instapay = await settingsRepo.getShopInstaPay();
    final wallet = await settingsRepo.getShopWallet();

    final List<String> paymentParts = [];
    if (instapay.isNotEmpty) paymentParts.add('إنستاباي: $instapay');
    if (wallet.isNotEmpty) paymentParts.add('محفظة/فودافون كاش: $wallet');
    if (phoneNum.isNotEmpty) paymentParts.add('تليفون: $phoneNum');

    final message = WhatsAppTemplateUtils.renderInstallmentReminder(
      customerName: item.customer.name,
      shopName: shopName,
      itemDescription: item.plan.itemDescription,
      installmentNumber: item.installment.installmentIndex,
      installmentCount: item.plan.installmentCount,
      amountPiasters: item.remainingForInstallmentPiasters,
      dueDate: item.installment.dueDate,
      remainingTotalPiasters: item.plan.totalPricePiasters - item.plan.downPaymentPiasters,
      paymentInfo: paymentParts.isNotEmpty ? paymentParts.join(' | ') : null,
      shopCode: shopCode,
    );

    final success = await WhatsAppTemplateUtils.launchWhatsApp(
      phone: item.customer.phone!,
      message: message,
    );

    if (!success && context.mounted) {
      await WhatsAppTemplateUtils.launchSms(phone: item.customer.phone!, message: message);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dueAsync = ref.watch(dueInstallmentsStreamProvider);

    return dueAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('خطأ: $e')),
      data: (dueList) {
        if (dueList.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified_rounded, size: 56, color: AppColors.primaryGreen),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'مفيش أقساط مستحقة أو متأخرة اليوم 🎉',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'كل عملاء الأقساط منتظمين في السداد حتى الآن.',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        final totalDuePiasters = dueList.fold<int>(
          0,
          (sum, item) => sum + item.remainingForInstallmentPiasters,
        );

        return ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 88),
          children: [
            // Summary header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.debtRed.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.debtRed.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مطلوب تحصيل (${dueList.length}) قسط:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      MoneyUtils.formatMoney(totalDuePiasters),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.debtRed),
                    ),
                  ],
                ),
              ),
            ),

            // Installment items
            ...dueList.map((item) {
              final isOverdue = item.isOverdue;
              final isDueToday = item.isDueToday;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: isOverdue
                        ? AppColors.debtRed.withValues(alpha: 0.6)
                        : theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                    width: isOverdue ? 1.5 : 1,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => InstallmentPlanDetailsScreen(planId: item.plan.id),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top row: Customer + Status Badge
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: isOverdue
                                  ? AppColors.debtRed.withValues(alpha: 0.12)
                                  : theme.colorScheme.primaryContainer,
                              child: Icon(
                                isOverdue ? Icons.warning_amber_rounded : Icons.calendar_today_rounded,
                                size: 20,
                                color: isOverdue ? AppColors.debtRed : theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.customer.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${item.plan.itemDescription} • القسط (${item.installment.installmentIndex} من ${item.plan.installmentCount})',
                                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  MoneyUtils.formatMoney(item.remainingForInstallmentPiasters),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: isOverdue ? AppColors.debtRed : AppColors.primaryGreen,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                if (isOverdue)
                                  Text(
                                    'متأخر ${item.daysOverdue} يوم',
                                    style: const TextStyle(color: AppColors.debtRed, fontSize: 11, fontWeight: FontWeight.bold),
                                  )
                                else if (isDueToday)
                                  const Text(
                                    'مستحق اليوم 🔔',
                                    style: TextStyle(color: Colors.blue, fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 1),
                        const SizedBox(height: 8),

                        // Action Buttons: Call, WhatsApp, Pay
                        Wrap(
                          alignment: WrapAlignment.end,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            if (item.customer.phone != null && item.customer.phone!.isNotEmpty) ...[
                              IconButton(
                                icon: const Icon(Icons.call_rounded, size: 20),
                                tooltip: 'اتصال',
                                onPressed: () => _callCustomer(item.customer.phone!),
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.chat_outlined, size: 16, color: AppColors.primaryGreen),
                                label: const Text('واتساب', style: TextStyle(color: AppColors.primaryGreen, fontSize: 13)),
                                onPressed: () => _sendWhatsAppReminder(context: context, ref: ref, item: item),
                              ),
                            ],
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGreen,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(80, 36),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              icon: const Icon(Icons.payment_rounded, size: 16),
                              label: const Text('سداد', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => PayInstallmentDialog(
                                    planId: item.plan.id,
                                    installment: item.installment,
                                    defaultAmountPiasters: item.remainingForInstallmentPiasters,
                                    itemDescription: item.plan.itemDescription,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
