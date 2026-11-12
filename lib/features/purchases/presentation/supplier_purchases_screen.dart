import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../l10n/l10n.dart';
import 'purchase_form_screen.dart';
import 'purchase_providers.dart';
import 'supplier_purchase_details_screen.dart';

class SupplierPurchasesScreen extends ConsumerWidget {
  final String supplierId;
  final String supplierName;

  const SupplierPurchasesScreen({
    super.key,
    required this.supplierId,
    required this.supplierName,
  });

  Future<void> _addPurchase(BuildContext context, WidgetRef ref) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => PurchaseFormScreen(
          supplierId: supplierId,
          supplierName: supplierName,
        ),
      ),
    );
    if (!context.mounted) return;
    ref.invalidate(supplierPurchasesProvider(supplierId));
    if (saved == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(L10n.t.supplierPurchaseSaved)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchases = ref.watch(supplierPurchasesProvider(supplierId));
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t.supplierPurchasesTitle)),
      body: purchases.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text(L10n.t.supplierPurchaseLoadError)),
        data: (invoices) {
          if (invoices.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  L10n.t.supplierPurchaseNoInvoices,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(supplierPurchasesProvider(supplierId)),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
              itemCount: invoices.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                final paymentLabel =
                    invoice.paymentType == PurchasePaymentType.cash
                    ? L10n.t.supplierPurchaseCash
                    : L10n.t.supplierPurchaseCredit;
                final invoiceReference =
                    invoice.invoiceNumber?.isNotEmpty == true
                    ? invoice.invoiceNumber!
                    : DateFormat(
                        'yyyy/MM/dd',
                      ).format(invoice.occurredAt.toLocal());
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        invoice.paymentType == PurchasePaymentType.cash
                            ? Icons.payments_outlined
                            : Icons.event_note_outlined,
                      ),
                    ),
                    title: Text(
                      invoiceReference,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '$paymentLabel · '
                      '${DateFormat('yyyy/MM/dd').format(invoice.occurredAt.toLocal())}',
                    ),
                    trailing: Text(
                      MoneyUtils.formatMoney(invoice.totalPiasters),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () => Navigator.of(context).push<void>(
                      MaterialPageRoute(
                        builder: (_) => SupplierPurchaseDetailsScreen(
                          purchaseId: invoice.id,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addPurchase(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: Text(L10n.t.supplierPurchaseNew),
      ),
    );
  }
}
