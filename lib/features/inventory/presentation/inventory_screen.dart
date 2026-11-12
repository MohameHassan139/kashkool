import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/quantity.dart';
import '../../../l10n/l10n.dart';
import '../../quick_pos/presentation/quick_pos_screen.dart';
import '../domain/product_with_stock.dart';
import 'inventory_providers.dart';
import 'product_details_screen.dart';
import 'product_form_screen.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openForm([ProductWithStock? product]) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => ProductFormScreen(product: product)),
    );
    if (!mounted) return;
    ref.invalidate(inventoryProductsStreamProvider);
    if (saved == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(L10n.t.inventoryProductSaved)));
    }
  }

  Future<void> _openDetails(ProductWithStock product) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(productId: product.product.id),
      ),
    );
    if (mounted) ref.invalidate(inventoryProductsStreamProvider);
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(inventoryProductsStreamProvider);
    final searchQuery = ref.watch(inventorySearchQueryProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.t.inventoryTitle),
        actions: [
          IconButton(
            tooltip: L10n.t.quickPosOpen,
            onPressed: () => Navigator.of(context).push<void>(
              MaterialPageRoute(builder: (_) => const QuickPosScreen()),
            ),
            icon: const Icon(Icons.point_of_sale_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) =>
                  ref.read(inventorySearchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: L10n.t.inventorySearchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          ref
                                  .read(inventorySearchQueryProvider.notifier)
                                  .state =
                              '';
                        },
                        icon: const Icon(Icons.clear_rounded),
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: productsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(L10n.t.inventorySaveFailed),
                ),
              ),
              data: (products) {
                if (products.isEmpty) {
                  final hasQuery = searchQuery.trim().isNotEmpty;
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 56,
                            color: theme.disabledColor,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            hasQuery
                                ? L10n.t.inventoryNoSearchResults
                                : L10n.t.inventoryNoProducts,
                            style: theme.textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          if (!hasQuery) ...[
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: _openForm,
                              icon: const Icon(Icons.add_rounded),
                              label: Text(L10n.t.inventoryAddProduct),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async =>
                      ref.invalidate(inventoryProductsStreamProvider),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 96),
                    itemCount: products.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return _ProductTile(
                        item: item,
                        onTap: () => _openDetails(item),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add_rounded),
        label: Text(L10n.t.inventoryAddProduct),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  final ProductWithStock item;
  final VoidCallback onTap;

  const _ProductTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final color = item.isLowStock
        ? AppColors.warningAmber
        : AppColors.paymentGreen;
    final status = item.isLowStock
        ? L10n.t.inventoryLowStock
        : L10n.t.inventoryInStock;

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(Icons.inventory_2_outlined, color: color),
        ),
        title: Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${L10n.t.inventoryCurrentStock}: '
          '${QuantityUtils.formatMilliUnits(item.quantityMilliUnits)} '
          '${product.unitLabel} · ${MoneyUtils.formatMoney(product.salePricePiasters)}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              status,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
            if (product.barcode != null)
              Text(
                product.barcode!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}
