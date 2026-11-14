import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/phone.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../../installments/presentation/add_installment_plan_screen.dart';
import '../../installments/presentation/installment_plan_details_screen.dart';
import '../../installments/presentation/installments_providers.dart';
import '../../statement/presentation/statement_preview_screen.dart';
import '../../transactions/presentation/add_transaction_bottom_sheet.dart';
import '../../transactions/presentation/transaction_details_bottom_sheet.dart';
import '../data/customer_photo_repository.dart';
import '../data/customer_repository.dart';
import 'add_edit_customer_screen.dart';
import 'customer_photos_screen.dart';
import 'customers_providers.dart';
import 'widgets/credit_limit_progress_bar.dart';
import 'widgets/rating_badge.dart';
import '../../../l10n/l10n.dart';

/// Full details screen for a single customer.
class CustomerDetailsScreen extends ConsumerWidget {
  final String customerId;

  const CustomerDetailsScreen({super.key, required this.customerId});

  Future<void> _callPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    try {
      await launchUrl(uri);
    } catch (_) {}
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, Customer customer, int balance) async {
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(customerRepositoryProvider);

    final bool isIndebted = balance != 0;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          l10n.deleteCustomerConfirm,
          style: TextStyle(color: isIndebted ? AppColors.debtRed : null),
        ),
        content: Text(
          isIndebted
              ? l10n.deleteCustomerWarningDebt(MoneyUtils.formatMoney(balance))
              : l10n.deleteCustomerSafeConfirm(customer.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.debtRed,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await repo.deleteCustomer(customer.id);
      if (context.mounted) {
        AppGlassToast.showSuccess(context, l10n.customerDeleted);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final customerAsync = ref.watch(customerDetailsStreamProvider(customerId));
    final transactionsAsync = ref.watch(customerTransactionsStreamProvider(customerId));

    return customerAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: Text(l10n.customerDetails)),
        body: Center(child: Text(err.toString())),
      ),
      data: (item) {
        if (item == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.customerDetails)),
            body: Center(child: Text(l10n.noCustomersTitle)),
          );
        }

        final customer = item.customer;
        final balance = item.balancePiasters;

        final Color balanceColor;
        final String balanceText;
        final String statusLabel;

        if (balance > 0) {
          balanceColor = AppColors.debtRed;
          balanceText = MoneyUtils.formatMoney(balance);
          statusLabel = l10n.debt;
        } else if (balance == 0) {
          balanceColor = AppColors.paymentGreen;
          balanceText = l10n.settled;
          statusLabel = '';
        } else {
          balanceColor = AppColors.primaryBlueLight;
          balanceText = MoneyUtils.formatMoney(balance.abs());
          statusLabel = l10n.hePaid;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(customer.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.point_of_sale_rounded),
                tooltip: l10n.quickPosTitle,
                onPressed: () => context.push('/pos?customerId=${customer.id}'),
              ),
              _PhotosButton(customerId: customer.id, customerName: customer.name),
              IconButton(
                icon: const Icon(Icons.picture_as_pdf_outlined),
                tooltip: l10n.statementTitle,
                onPressed: () {
                  final txs = transactionsAsync.valueOrNull ?? const [];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => StatementPreviewScreen(
                        customer: customer,
                        transactions: txs,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: l10n.editCustomer,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddEditCustomerScreen(customer: customer),
                    ),
                  );
                },
              ),
              PopupMenuButton<String>(
                onSelected: (val) {
                  if (val == 'delete') {
                    _confirmDelete(context, ref, customer, balance);
                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline_rounded, color: AppColors.debtRed),
                        const SizedBox(width: 8),
                        Text(l10n.deleteCustomer, style: const TextStyle(color: AppColors.debtRed)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              // Header Card with Balance & Details
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                  ),
                ),
                child: Column(
                  children: [
                    // Balance Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          statusLabel.isEmpty ? l10n.currentBalance : '${l10n.currentBalance} ($statusLabel)',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        CustomerRatingBadge(
                          customerName: customer.name,
                          rating: item.rating,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      balanceText,
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: balanceColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Phone and Call action
                    if (customer.phone != null && customer.phone!.isNotEmpty) ...[
                      InkWell(
                        onTap: () => _callPhone(customer.phone!),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.phone_in_talk_rounded, size: 20, color: AppColors.paymentGreen),
                              const SizedBox(width: 8),
                              Text(
                                PhoneUtils.formatDisplay(customer.phone),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.paymentGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // Credit limit badge & progress bar if set
                    if (customer.creditLimitPiasters != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: item.isCreditLimitExceeded
                              ? AppColors.debtContainer(isDark)
                              : (isDark ? const Color(0xFF374151) : AppColors.neutralGreyLight),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item.isCreditLimitExceeded
                              ? '${l10n.creditLimitExceeded} (${l10n.creditLimitLabel(MoneyUtils.formatMoney(customer.creditLimitPiasters!))})'
                              : l10n.creditLimitLabel(MoneyUtils.formatMoney(customer.creditLimitPiasters!)),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: item.isCreditLimitExceeded
                                ? (isDark ? AppColors.debtRedDark : AppColors.debtRed)
                                : (isDark ? const Color(0xFFE5E7EB) : AppColors.neutralGreyDark),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: CreditLimitProgressBar(
                          balancePiasters: balance,
                          limitPiasters: customer.creditLimitPiasters,
                          showLabel: false,
                        ),
                      ),
                    ],

                    // Notes
                    if (customer.notes != null && customer.notes!.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        customer.notes!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppColors.neutralGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),

              // The Two Primary Action Buttons: عليه (Red) & دفع (Green)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // عليه (Debt) Button
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.debtRed,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.remove_circle_outline_rounded, size: 26),
                        label: Text(
                          l10n.debt,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (ctx) => AddTransactionBottomSheet(
                              partyType: PartyType.customer,
                              partyId: customer.id,
                              partyName: customer.name,
                              currentBalancePiasters: balance,
                              creditLimitPiasters: customer.creditLimitPiasters,
                              initialType: TransactionType.debt,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // دفع (Payment) Button
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.paymentGreen,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle_outline_rounded, size: 26),
                        label: Text(
                          l10n.payment,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (ctx) => AddTransactionBottomSheet(
                              partyType: PartyType.customer,
                              partyId: customer.id,
                              partyName: customer.name,
                              currentBalancePiasters: balance,
                              creditLimitPiasters: customer.creditLimitPiasters,
                              initialType: TransactionType.payment,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Customer Installments Card
              ref.watch(customerInstallmentPlansStreamProvider(customer.id)).when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                    data: (plans) {
                      final activePlans = plans.where((p) => p.plan.status == PlanStatus.active).toList();
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                        child: Card(
                          elevation: 0,
                          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              children: [
                                const Icon(Icons.receipt_long_rounded, color: AppColors.primaryGreen),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    activePlans.isNotEmpty
                                        ? L10n.t.customerDetailsScreen1(activePlans.length, MoneyUtils.formatMoney(activePlans.fold<int>(0, (s, p) => s + p.remainingPiasters)))
                                        : L10n.t.customerDetailsScreen2,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                ),
                                if (activePlans.isNotEmpty)
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => InstallmentPlanDetailsScreen(planId: activePlans.first.plan.id),
                                        ),
                                      );
                                    },
                                    child: Text(L10n.t.customerDetailsScreen3),
                                  ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryGreen),
                                  tooltip: L10n.t.customerDetailsScreen4,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => AddInstallmentPlanScreen(initialCustomerId: customer.id),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

              const SizedBox(height: 8),
              const Divider(height: 1),

              // Transaction History List
              Expanded(
                child: transactionsAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, s) => Center(child: Text(e.toString())),
                  data: (txList) {
                    if (txList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt_long_outlined, size: 48, color: theme.disabledColor),
                              const SizedBox(height: 12),
                              Text(
                                l10n.noTransactionsYet,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final dateFmt = DateFormat('yyyy/MM/dd · hh:mm a');

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: txList.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (ctx, idx) {
                        final tx = txList[idx];
                        final isDebt = tx.type == TransactionType.debt;
                        final color = isDebt ? AppColors.debtRed : AppColors.paymentGreen;

                        return ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (ctx) => TransactionDetailsBottomSheet(
                                transaction: tx,
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: color.withValues(alpha: 0.1),
                            child: Icon(
                              isDebt ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                              color: color,
                            ),
                          ),
                          title: Text(
                            isDebt ? l10n.debt : l10n.payment,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          subtitle: Text(
                            tx.note != null && tx.note!.isNotEmpty
                                ? '${tx.note!} · ${dateFmt.format(tx.occurredAt)}'
                                : dateFmt.format(tx.occurredAt),
                          ),
                          trailing: Text(
                            MoneyUtils.formatMoney(tx.amountPiasters),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: color,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// App-bar button that opens the customer's photos, with a count badge.
class _PhotosButton extends ConsumerWidget {
  final String customerId;
  final String customerName;
  const _PhotosButton({required this.customerId, required this.customerName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(customerPhotosProvider(customerId)).valueOrNull?.length ?? 0;
    return IconButton(
      tooltip: L10n.t.customerDetailsScreen5,
      onPressed: () => CustomerPhotosScreen.open(context, customerId: customerId, customerName: customerName),
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text('$count'),
        child: const Icon(Icons.photo_library_outlined),
      ),
    );
  }
}
