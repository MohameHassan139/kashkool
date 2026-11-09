import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/phone.dart';
import '../../../l10n/app_localizations.dart';
import '../../transactions/presentation/add_transaction_bottom_sheet.dart';
import '../../transactions/presentation/transaction_details_bottom_sheet.dart';
import '../data/supplier_repository.dart';
import 'add_edit_supplier_screen.dart';
import 'suppliers_providers.dart';

/// Full details screen for a single supplier or distributor.
class SupplierDetailsScreen extends ConsumerWidget {
  final String supplierId;

  const SupplierDetailsScreen({super.key, required this.supplierId});

  Future<void> _callPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    try {
      await launchUrl(uri);
    } catch (_) {}
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Supplier supplier,
    int balance,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(supplierRepositoryProvider);

    final bool isIndebted = balance != 0;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          l10n.deleteSupplierConfirm,
          style: TextStyle(color: isIndebted ? AppColors.debtRed : null),
        ),
        content: Text(
          isIndebted
              ? l10n.deleteSupplierWarningDebt(MoneyUtils.formatMoney(balance))
              : l10n.deleteSupplierSafeConfirm(supplier.name),
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
      await repo.deleteSupplier(supplier.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.supplierDeleted),
            backgroundColor: AppColors.debtRed,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final supplierAsync = ref.watch(supplierDetailsStreamProvider(supplierId));
    final transactionsAsync = ref.watch(supplierTransactionsStreamProvider(supplierId));

    return supplierAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: Text(l10n.supplierDetails)),
        body: Center(child: Text(err.toString())),
      ),
      data: (item) {
        if (item == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.supplierDetails)),
            body: Center(child: Text(l10n.noSuppliersTitle)),
          );
        }

        final supplier = item.supplier;
        final balance = item.balancePiasters;

        final Color balanceColor;
        final String balanceText;
        final String statusLabel;

        if (balance > 0) {
          balanceColor = AppColors.debtRed;
          balanceText = MoneyUtils.formatMoney(balance);
          statusLabel = l10n.iOweHim;
        } else if (balance == 0) {
          balanceColor = AppColors.paymentGreen;
          balanceText = l10n.settled;
          statusLabel = '';
        } else {
          balanceColor = AppColors.primaryBlueLight;
          balanceText = MoneyUtils.formatMoney(balance.abs());
          statusLabel = l10n.hePaid;
        }

        final visitDay = item.visitDayLabel;

        return Scaffold(
          appBar: AppBar(
            title: Text(supplier.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: l10n.editSupplier,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddEditSupplierScreen(supplier: supplier),
                    ),
                  );
                },
              ),
              PopupMenuButton<String>(
                onSelected: (val) {
                  if (val == 'delete') {
                    _confirmDelete(context, ref, supplier, balance);
                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline_rounded, color: AppColors.debtRed),
                        const SizedBox(width: 8),
                        Text(l10n.deleteSupplier,
                            style: const TextStyle(color: AppColors.debtRed)),
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
                          statusLabel.isEmpty
                              ? l10n.currentBalance
                              : '${l10n.currentBalance} ($statusLabel)',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            fontWeight: FontWeight.w600,
                          ),
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

                    // Company Name if present
                    if (supplier.company != null && supplier.company!.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.business_rounded, size: 18, color: AppColors.neutralGrey),
                          const SizedBox(width: 6),
                          Text(
                            supplier.company!,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],

                    // Visit Day if set
                    if (visitDay != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF0F172A) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 15, color: theme.colorScheme.primary),
                            const SizedBox(width: 6),
                            Text(
                              l10n.visitDayPrefix(visitDay),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // Phone and Call action
                    if (supplier.phone != null && supplier.phone!.isNotEmpty) ...[
                      InkWell(
                        onTap: () => _callPhone(supplier.phone!),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.phone_in_talk_rounded,
                                  size: 20, color: AppColors.paymentGreen),
                              const SizedBox(width: 8),
                              Text(
                                PhoneUtils.formatDisplay(supplier.phone),
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

                    // Notes
                    if (supplier.notes != null && supplier.notes!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        supplier.notes!,
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

              // Two Primary Action Buttons: عليّا (Red) & دفعتله (Green)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // عليّا (Debt) Button
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
                          l10n.iOweHim,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (ctx) => AddTransactionBottomSheet(
                              partyType: PartyType.supplier,
                              partyId: supplier.id,
                              partyName: supplier.name,
                              currentBalancePiasters: balance,
                              initialType: TransactionType.debt,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),

                    // دفعتله (Payment) Button
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
                          l10n.iPaidHim,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (ctx) => AddTransactionBottomSheet(
                              partyType: PartyType.supplier,
                              partyId: supplier.id,
                              partyName: supplier.name,
                              currentBalancePiasters: balance,
                              initialType: TransactionType.payment,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Divider(height: 1),

              // Transaction History List
              Expanded(
                child: transactionsAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text(err.toString())),
                  data: (txList) {
                    if (txList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt_long_outlined,
                                  size: 48, color: theme.disabledColor),
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
                              isDebt
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              color: color,
                            ),
                          ),
                          title: Text(
                            isDebt ? l10n.iOweHim : l10n.iPaidHim,
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
