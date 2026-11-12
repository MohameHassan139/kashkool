import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/quantity.dart';
import '../../../l10n/l10n.dart';
import '../data/purchase_repository.dart';
import '../domain/purchase_details.dart';
import 'purchase_providers.dart';

class SupplierPurchaseDetailsScreen extends ConsumerWidget {
  final String purchaseId;

  const SupplierPurchaseDetailsScreen({super.key, required this.purchaseId});

  Future<void> _returnItem(
    BuildContext context,
    WidgetRef ref,
    String supplierId,
    PurchaseItemWithReturns item,
  ) async {
    final request = await _showReturnDialog(context, item);
    if (request == null || !context.mounted) return;

    try {
      await ref
          .read(purchaseRepositoryProvider)
          .returnPurchaseItem(
            purchaseItemId: item.item.id,
            quantityMilliUnits: request.quantityMilliUnits,
            note: request.note,
          );
      ref.invalidate(purchaseDetailsProvider(purchaseId));
      ref.invalidate(supplierPurchasesProvider(supplierId));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L10n.t.supplierPurchaseReturnSaved)),
        );
      }
    } catch (error) {
      if (!context.mounted) return;
      final message = error.toString().contains('exceeds')
          ? L10n.t.supplierPurchaseReturnLimit
          : L10n.t.supplierPurchaseSaveFailed;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<_ReturnRequest?> _showReturnDialog(
    BuildContext context,
    PurchaseItemWithReturns item,
  ) {
    final quantityController = TextEditingController();
    final noteController = TextEditingController();
    String? errorText;

    return showDialog<_ReturnRequest>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(L10n.t.supplierPurchaseReturn),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  '${item.item.productName} · '
                  '${L10n.t.supplierPurchaseRemaining}: '
                  '${QuantityUtils.formatMilliUnits(item.remainingQuantityMilliUnits)} '
                  '${item.item.unitLabel}',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: quantityController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: L10n.t.supplierPurchaseReturnQuantity,
                  errorText: errorText,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: L10n.t.inventoryNote,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(L10n.t.inventoryCancel),
            ),
            FilledButton(
              onPressed: () {
                final quantity = QuantityUtils.parseMilliUnits(
                  quantityController.text,
                );
                if (quantity == null || quantity <= 0) {
                  setDialogState(
                    () => errorText = L10n.t.supplierPurchaseInvalidInput,
                  );
                  return;
                }
                Navigator.pop(
                  context,
                  _ReturnRequest(
                    quantityMilliUnits: quantity,
                    note: noteController.text.trim(),
                  ),
                );
              },
              child: Text(L10n.t.supplierPurchaseReturn),
            ),
          ],
        ),
      ),
    ).whenComplete(() {
      quantityController.dispose();
      noteController.dispose();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(purchaseDetailsProvider(purchaseId));
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t.supplierPurchaseDetails)),
      body: details.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text(L10n.t.supplierPurchaseLoadError)),
        data: (purchase) {
          if (purchase == null) {
            return Center(child: Text(L10n.t.supplierPurchaseLoadError));
          }
          return _PurchaseDetailsBody(
            purchase: purchase,
            onReturnItem: (item) =>
                _returnItem(context, ref, purchase.invoice.supplierId, item),
          );
        },
      ),
    );
  }
}

class _PurchaseDetailsBody extends StatelessWidget {
  final PurchaseDetails purchase;
  final ValueChanged<PurchaseItemWithReturns> onReturnItem;

  const _PurchaseDetailsBody({
    required this.purchase,
    required this.onReturnItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final invoice = purchase.invoice;
    final paymentLabel = invoice.paymentType == PurchasePaymentType.cash
        ? L10n.t.supplierPurchaseCash
        : L10n.t.supplierPurchaseCredit;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (invoice.invoiceNumber?.isNotEmpty == true)
                  Text(
                    '${L10n.t.supplierPurchaseInvoiceNumber}: '
                    '${invoice.invoiceNumber}',
                    style: theme.textTheme.titleMedium,
                  ),
                Text('${L10n.t.supplierPurchasePaymentType}: $paymentLabel'),
                const SizedBox(height: 8),
                Text(
                  '${L10n.t.supplierPurchaseTotal}: '
                  '${MoneyUtils.formatMoney(invoice.totalPiasters)}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(L10n.t.supplierPurchaseItems, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final item in purchase.items)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.item.productName,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${QuantityUtils.formatMilliUnits(item.item.quantityMilliUnits)} '
                    '${item.item.unitLabel} × '
                    '${MoneyUtils.formatMoney(item.item.unitCostPiasters)}',
                  ),
                  Text(
                    '${L10n.t.supplierPurchaseReturned}: '
                    '${QuantityUtils.formatMilliUnits(item.returnedQuantityMilliUnits)} · '
                    '${L10n.t.supplierPurchaseRemaining}: '
                    '${QuantityUtils.formatMilliUnits(item.remainingQuantityMilliUnits)} '
                    '${item.item.unitLabel}',
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: item.remainingQuantityMilliUnits <= 0
                          ? null
                          : () => onReturnItem(item),
                      icon: const Icon(Icons.assignment_return_outlined),
                      label: Text(L10n.t.supplierPurchaseReturn),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ReturnRequest {
  final int quantityMilliUnits;
  final String note;

  const _ReturnRequest({required this.quantityMilliUnits, required this.note});
}
