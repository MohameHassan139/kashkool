import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/quantity.dart';
import '../../../l10n/l10n.dart';
import '../data/inventory_repository.dart';
import '../domain/product_with_stock.dart';
import 'inventory_providers.dart';
import 'product_form_screen.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  Future<void> _edit(
    BuildContext context,
    ProductWithStock product,
    WidgetRef ref,
  ) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => ProductFormScreen(product: product)),
    );
    ref.invalidate(inventoryProductStreamProvider(productId));
    ref.invalidate(inventoryMovementsStreamProvider(productId));
    if (saved == true && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(L10n.t.inventoryProductSaved)));
    }
  }

  Future<void> _adjustStock(
    BuildContext context,
    ProductWithStock product,
    WidgetRef ref,
  ) async {
    final adjustment = await _showAdjustmentDialog(context);
    if (adjustment == null || !context.mounted) return;

    try {
      await ref
          .read(inventoryRepositoryProvider)
          .adjustStock(
            productId: product.product.id,
            quantityDeltaMilliUnits: adjustment.quantityDeltaMilliUnits,
            note: adjustment.note,
            unitCostPiasters: adjustment.quantityDeltaMilliUnits > 0
                ? product.product.purchasePricePiasters
                : null,
          );
      ref.invalidate(inventoryProductStreamProvider(productId));
      ref.invalidate(inventoryMovementsStreamProvider(productId));
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(L10n.t.inventoryStockSaved)));
      }
    } catch (error) {
      if (!context.mounted) return;
      final message = error.toString().contains('below zero')
          ? L10n.t.inventoryStockCannotBeNegative
          : L10n.t.inventorySaveFailed;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(L10n.t.inventoryDelete),
        content: Text(L10n.t.inventoryDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(L10n.t.inventoryCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(L10n.t.inventoryDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    try {
      await ref.read(inventoryRepositoryProvider).softDeleteProduct(productId);
      if (context.mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(L10n.t.inventorySaveFailed)));
    }
  }

  Future<_StockAdjustment?> _showAdjustmentDialog(BuildContext context) {
    final quantityController = TextEditingController();
    final noteController = TextEditingController();
    var isAdding = true;
    String? errorText;

    return showDialog<_StockAdjustment>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(L10n.t.inventoryAdjustStock),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(
                    value: true,
                    label: Text(L10n.t.inventoryAddStock),
                    icon: const Icon(Icons.add_rounded),
                  ),
                  ButtonSegment(
                    value: false,
                    label: Text(L10n.t.inventoryRemoveStock),
                    icon: const Icon(Icons.remove_rounded),
                  ),
                ],
                selected: {isAdding},
                onSelectionChanged: (selection) =>
                    setDialogState(() => isAdding = selection.first),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: quantityController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: L10n.t.inventoryQuantity,
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
                    () => errorText = quantity == null
                        ? L10n.t.inventoryInvalidQuantity
                        : L10n.t.inventoryQuantityRequired,
                  );
                  return;
                }
                Navigator.pop(
                  context,
                  _StockAdjustment(
                    quantityDeltaMilliUnits: isAdding ? quantity : -quantity,
                    note: noteController.text.trim(),
                  ),
                );
              },
              child: Text(L10n.t.inventorySave),
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
    final productAsync = ref.watch(inventoryProductStreamProvider(productId));
    final movementsAsync = ref.watch(
      inventoryMovementsStreamProvider(productId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.t.inventoryTitle),
        actions: [
          productAsync.valueOrNull == null
              ? const SizedBox.shrink()
              : PopupMenuButton<String>(
                  onSelected: (action) {
                    if (action == 'edit') {
                      _edit(context, productAsync.valueOrNull!, ref);
                    } else if (action == 'delete') {
                      _delete(context, ref);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text(L10n.t.inventoryEditProduct),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(L10n.t.inventoryDelete),
                    ),
                  ],
                ),
        ],
      ),
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text(L10n.t.inventorySaveFailed)),
        data: (item) {
          if (item == null) {
            return Center(child: Text(L10n.t.inventoryNoProducts));
          }
          return _ProductDetailsBody(
            item: item,
            movementsAsync: movementsAsync,
            onAdjust: () => _adjustStock(context, item, ref),
          );
        },
      ),
    );
  }
}

class _ProductDetailsBody extends StatelessWidget {
  final ProductWithStock item;
  final AsyncValue<List<InventoryMovement>> movementsAsync;
  final VoidCallback onAdjust;

  const _ProductDetailsBody({
    required this.item,
    required this.movementsAsync,
    required this.onAdjust,
  });

  String _movementLabel(InventoryMovementType type) {
    switch (type) {
      case InventoryMovementType.opening:
        return L10n.t.inventoryMovementOpening;
      case InventoryMovementType.adjustment:
        return L10n.t.inventoryMovementAdjustment;
      case InventoryMovementType.purchase:
        return L10n.t.inventoryMovementPurchase;
      case InventoryMovementType.sale:
        return L10n.t.inventoryMovementSale;
      case InventoryMovementType.customerReturn:
        return L10n.t.inventoryMovementCustomerReturn;
      case InventoryMovementType.supplierReturn:
        return L10n.t.inventoryMovementSupplierReturn;
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final theme = Theme.of(context);
    final stockColor = item.isLowStock
        ? theme.colorScheme.error
        : theme.colorScheme.primary;

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: theme.textTheme.headlineSmall),
                if (product.category != null) ...[
                  const SizedBox(height: 4),
                  Text(product.category!),
                ],
                if (product.barcode != null) ...[
                  const SizedBox(height: 4),
                  Text(product.barcode!),
                ],
                const SizedBox(height: 18),
                Text(
                  '${L10n.t.inventoryCurrentStock}: '
                  '${QuantityUtils.formatMilliUnits(item.quantityMilliUnits)} '
                  '${product.unitLabel}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: stockColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    Text(
                      '${L10n.t.inventoryPurchasePrice}: '
                      '${MoneyUtils.formatMoney(product.purchasePricePiasters)}',
                    ),
                    Text(
                      '${L10n.t.inventorySalePrice}: '
                      '${MoneyUtils.formatMoney(product.salePricePiasters)}',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onAdjust,
                    icon: const Icon(Icons.swap_vert_rounded),
                    label: Text(L10n.t.inventoryAdjustStock),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              L10n.t.inventoryMovementHistory,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
        Expanded(
          child: movementsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                Center(child: Text(L10n.t.inventorySaveFailed)),
            data: (movements) {
              if (movements.isEmpty) {
                return Center(child: Text(L10n.t.inventoryNoMovements));
              }
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                itemCount: movements.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final movement = movements[index];
                  final quantity = movement.quantityDeltaMilliUnits;
                  final date = DateFormat(
                    'yyyy/MM/dd  HH:mm',
                  ).format(movement.occurredAt.toLocal());
                  return ListTile(
                    leading: Icon(
                      quantity > 0
                          ? Icons.add_circle_outline_rounded
                          : Icons.remove_circle_outline_rounded,
                      color: quantity > 0
                          ? theme.colorScheme.primary
                          : theme.colorScheme.error,
                    ),
                    title: Text(_movementLabel(movement.type)),
                    subtitle: Text(
                      [
                        date,
                        if (movement.note?.isNotEmpty == true) movement.note!,
                      ].join(' · '),
                    ),
                    trailing: Text(
                      '${quantity > 0 ? '+' : ''}'
                      '${QuantityUtils.formatMilliUnits(quantity)} '
                      '${product.unitLabel}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: quantity > 0
                            ? theme.colorScheme.primary
                            : theme.colorScheme.error,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StockAdjustment {
  final int quantityDeltaMilliUnits;
  final String note;

  const _StockAdjustment({
    required this.quantityDeltaMilliUnits,
    required this.note,
  });
}
