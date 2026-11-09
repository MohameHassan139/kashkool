import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/whatsapp_template.dart';
import '../../settings/data/settings_repository.dart';
import '../data/installment_repository.dart';
import '../domain/installment_calculator.dart';
import 'installments_providers.dart';
import 'widgets/early_settlement_dialog.dart';
import 'widgets/installment_progress_bar.dart';
import 'widgets/pay_installment_dialog.dart';

/// Comprehensive Details Screen for an Installment Plan.
class InstallmentPlanDetailsScreen extends ConsumerWidget {
  final String planId;

  const InstallmentPlanDetailsScreen({super.key, required this.planId});

  Future<void> _callPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    try {
      await launchUrl(uri);
    } catch (_) {}
  }

  Future<void> _sendWhatsAppReminder({
    required BuildContext context,
    required WidgetRef ref,
    required String phone,
    required String customerName,
    required String itemDescription,
    required int installmentNumber,
    required int installmentCount,
    required int amountPiasters,
    required DateTime dueDate,
    required int remainingTotalPiasters,
  }) async {
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
      customerName: customerName,
      shopName: shopName,
      itemDescription: itemDescription,
      installmentNumber: installmentNumber,
      installmentCount: installmentCount,
      amountPiasters: amountPiasters,
      dueDate: dueDate,
      remainingTotalPiasters: remainingTotalPiasters,
      paymentInfo: paymentParts.isNotEmpty ? paymentParts.join(' | ') : null,
      shopCode: shopCode,
    );

    final success = await WhatsAppTemplateUtils.launchWhatsApp(
      phone: phone,
      message: message,
    );

    if (!success && context.mounted) {
      // Fallback to SMS
      await WhatsAppTemplateUtils.launchSms(phone: phone, message: message);
    }
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إلغاء خطة القسط'),
        content: const Text('هل أنت متأكد من رغبتك في إلغاء هذه الخطة؟ سيتم إيقاف التنبيهات مع الاحتفاظ بسجل المدفوعات.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('رجوع')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.debtRed, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('إلغاء الخطة'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(installmentRepositoryProvider).cancelPlan(planId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إلغاء خطة القسط')));
      }
    }
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف خطة القسط'),
        content: const Text('هل أنت متأكد من حذف خطة القسط نهائياً؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.debtRed, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('حذف نهائي'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(installmentRepositoryProvider).deletePlan(planId);
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حذف خطة القسط')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final planAsync = ref.watch(installmentPlanDetailsStreamProvider(planId));
    final dateFmt = DateFormat('yyyy/MM/dd');

    return planAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('تفاصيل القسط')),
        body: Center(child: Text('خطأ: $e')),
      ),
      data: (item) {
        if (item == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('تفاصيل القسط')),
            body: const Center(child: Text('خطة القسط غير موجودة أو تم حذفها')),
          );
        }

        final plan = item.plan;
        final customer = item.customer;
        final isCompleted = plan.status == PlanStatus.completed || item.isFullyPaid;
        final isCancelled = plan.status == PlanStatus.cancelled;

        return Scaffold(
          appBar: AppBar(
            title: Text(plan.itemDescription, style: const TextStyle(fontWeight: FontWeight.bold)),
            actions: [
              PopupMenuButton<String>(
                onSelected: (val) {
                  if (val == 'cancel') _confirmCancel(context, ref);
                  if (val == 'delete') _confirmDelete(context, ref);
                },
                itemBuilder: (ctx) => [
                  if (!isCompleted && !isCancelled)
                    const PopupMenuItem(value: 'cancel', child: Text('إلغاء الخطة')),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('حذف الخطة', style: TextStyle(color: AppColors.debtRed)),
                  ),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 1. Plan Overview Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Customer name & Call
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            child: const Icon(Icons.person, color: AppColors.primaryGreen),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customer.name,
                                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                if (customer.phone != null) ...[
                                  const SizedBox(height: 2),
                                  Text(customer.phone!, style: theme.textTheme.bodyMedium),
                                ],
                              ],
                            ),
                          ),
                          if (customer.phone != null)
                            IconButton.filledTonal(
                              icon: const Icon(Icons.call_rounded),
                              onPressed: () => _callPhone(customer.phone!),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),

                      // Financial Breakdown Table
                      Row(
                        children: [
                          const Expanded(child: Text('السعر الإجمالي:')),
                          Text(MoneyUtils.formatMoney(plan.totalPricePiasters),
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Expanded(child: Text('المقدم:')),
                          Text(MoneyUtils.formatMoney(plan.downPaymentPiasters),
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Expanded(child: Text('إجمالي المدفوع:')),
                          Text(
                            MoneyUtils.formatMoney(item.totalPaidWithDownPaymentPiasters),
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Expanded(child: Text('المتبقي:')),
                          Text(
                            MoneyUtils.formatMoney(item.remainingPiasters),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: item.remainingPiasters > 0 ? AppColors.debtRed : AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Progress Bar
                      InstallmentProgressBar(
                        paidCount: item.paidInstallmentsCount,
                        totalCount: item.totalInstallmentsCount,
                        remainingPiasters: item.remainingPiasters,
                        progressPercentage: item.progressPercentage,
                        isOverdue: item.hasOverdue && !isCompleted,
                      ),

                      // Action Button: Early Settlement
                      if (!isCompleted && !isCancelled && item.remainingPiasters > 0) ...[
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondaryContainer,
                            foregroundColor: theme.colorScheme.onSecondaryContainer,
                            minimumSize: const Size.fromHeight(48),
                          ),
                          icon: const Icon(Icons.verified_rounded),
                          label: const Text(
                            'سداد مبكر وتصفية بالكامل',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => EarlySettlementDialog(
                                planId: plan.id,
                                itemDescription: plan.itemDescription,
                                remainingPiasters: item.remainingPiasters,
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 2. Guarantor Card (if present)
              if (plan.guarantorName != null && plan.guarantorName!.trim().isNotEmpty) ...[
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.amber,
                          child: Icon(Icons.shield_rounded, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('الضامن: ${plan.guarantorName!}',
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                              if (plan.guarantorPhone != null && plan.guarantorPhone!.isNotEmpty)
                                Text(plan.guarantorPhone!, style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ),
                        if (plan.guarantorPhone != null && plan.guarantorPhone!.isNotEmpty) ...[
                          IconButton.filledTonal(
                            icon: const Icon(Icons.call_rounded, size: 18),
                            onPressed: () => _callPhone(plan.guarantorPhone!),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // 3. Contract Photo Preview (if present)
              if (plan.photoPath != null && plan.photoPath!.isNotEmpty) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.photo_library_outlined, color: AppColors.primaryGreen),
                  title: const Text('صورة العقد / إيصال الأمانة'),
                  subtitle: const Text('اضغط لعرض المستند بالحجم الكامل'),
                  trailing: const Icon(Icons.chevron_left_rounded),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppBar(
                              title: const Text('مستند القسط'),
                              leading: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.pop(ctx),
                              ),
                            ),
                            InteractiveViewer(
                              child: Image.file(
                                File(plan.photoPath!),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                const SizedBox(height: 8),
              ],

              // 4. Schedule Table Title
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'جدول الأقساط (${item.installments.length})',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (!isCompleted && !isCancelled)
                    TextButton.icon(
                      icon: const Icon(Icons.add_card_rounded, size: 18),
                      label: const Text('سداد دفعة حرة'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => PayInstallmentDialog(
                            planId: plan.id,
                            defaultAmountPiasters: item.nextDueInstallment?.amountPiasters ?? 100000,
                            itemDescription: plan.itemDescription,
                          ),
                        );
                      },
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // 5. Installment Rows
              ...item.installments.map((inst) {
                final isPaid = inst.paidPiasters >= inst.amountPiasters;
                final isPartial = inst.paidPiasters > 0 && !isPaid;
                final isOverdue = InstallmentCalculator.isOverdue(
                  dueDate: inst.dueDate,
                  amountPiasters: inst.amountPiasters,
                  paidPiasters: inst.paidPiasters,
                );
                final isDueToday = InstallmentCalculator.isDueToday(
                  dueDate: inst.dueDate,
                  amountPiasters: inst.amountPiasters,
                  paidPiasters: inst.paidPiasters,
                );

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isPaid
                          ? AppColors.primaryGreen.withValues(alpha: 0.3)
                          : (isOverdue
                              ? AppColors.debtRed.withValues(alpha: 0.5)
                              : theme.colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: isPaid
                                  ? AppColors.primaryGreen.withValues(alpha: 0.15)
                                  : (isOverdue
                                      ? AppColors.debtRed.withValues(alpha: 0.15)
                                      : theme.colorScheme.primaryContainer),
                              child: isPaid
                                  ? const Icon(Icons.check, color: AppColors.primaryGreen, size: 18)
                                  : Text(
                                      '${inst.installmentIndex}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: isOverdue ? AppColors.debtRed : theme.colorScheme.primary,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'القسط رقم ${inst.installmentIndex} • ${dateFmt.format(inst.dueDate)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 2),
                                  if (isPaid)
                                    Text(
                                      'تم السداد بالكامل ✓ (${MoneyUtils.formatMoney(inst.paidPiasters)})',
                                      style: const TextStyle(color: AppColors.primaryGreen, fontSize: 12),
                                    )
                                  else if (isPartial)
                                    Text(
                                      'مدفوع ${MoneyUtils.formatMoney(inst.paidPiasters)} من ${MoneyUtils.formatMoney(inst.amountPiasters)}',
                                      style: const TextStyle(color: AppColors.warningAmber, fontSize: 12),
                                    )
                                  else if (isOverdue)
                                    const Text('متأخر عن ميعاده ⚠️',
                                        style: TextStyle(color: AppColors.debtRed, fontSize: 12, fontWeight: FontWeight.bold))
                                  else if (isDueToday)
                                    const Text('مستحق السداد اليوم 🔔',
                                        style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold))
                                  else
                                    Text('قادم • ${MoneyUtils.formatMoney(inst.amountPiasters)}',
                                        style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 12)),
                                ],
                              ),
                            ),
                            Text(
                              MoneyUtils.formatMoney(inst.amountPiasters - inst.paidPiasters),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: isPaid ? AppColors.primaryGreen : (isOverdue ? AppColors.debtRed : null),
                              ),
                            ),
                          ],
                        ),

                        // Action Buttons for this Installment (Pay & WhatsApp Reminder)
                        if (!isPaid && !isCancelled) ...[
                          const SizedBox(height: 8),
                          const Divider(height: 1),
                          const SizedBox(height: 8),
                          Wrap(
                            alignment: WrapAlignment.end,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              // WhatsApp Reminder
                              if (customer.phone != null && customer.phone!.isNotEmpty)
                                TextButton.icon(
                                  icon: const Icon(Icons.chat_outlined, size: 16, color: AppColors.primaryGreen),
                                  label: const Text('تذكير واتساب', style: TextStyle(color: AppColors.primaryGreen, fontSize: 13)),
                                  onPressed: () {
                                    _sendWhatsAppReminder(
                                      context: context,
                                      ref: ref,
                                      phone: customer.phone!,
                                      customerName: customer.name,
                                      itemDescription: plan.itemDescription,
                                      installmentNumber: inst.installmentIndex,
                                      installmentCount: plan.installmentCount,
                                      amountPiasters: inst.amountPiasters - inst.paidPiasters,
                                      dueDate: inst.dueDate,
                                      remainingTotalPiasters: item.remainingPiasters,
                                    );
                                  },
                                ),

                              // Pay Installment Button
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryGreen,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(90, 36),
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                ),
                                icon: const Icon(Icons.payment_rounded, size: 16),
                                label: const Text('سداد', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => PayInstallmentDialog(
                                      planId: plan.id,
                                      installment: inst,
                                      defaultAmountPiasters: inst.amountPiasters - inst.paidPiasters,
                                      itemDescription: plan.itemDescription,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
