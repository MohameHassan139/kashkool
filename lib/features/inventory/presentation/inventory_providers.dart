import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../data/inventory_repository.dart';
import '../domain/product_with_stock.dart';

final inventorySearchQueryProvider = StateProvider<String>((ref) => '');

final inventoryProductsStreamProvider = StreamProvider<List<ProductWithStock>>((
  ref,
) {
  final repository = ref.watch(inventoryRepositoryProvider);
  final query = ref.watch(inventorySearchQueryProvider);
  return repository.watchProducts(query: query);
});

final inventoryProductStreamProvider =
    StreamProvider.family<ProductWithStock?, String>((ref, productId) {
      final repository = ref.watch(inventoryRepositoryProvider);
      return repository.watchProducts().map((products) {
        for (final product in products) {
          if (product.product.id == productId) return product;
        }
        return null;
      });
    });

final inventoryMovementsStreamProvider =
    StreamProvider.family<List<InventoryMovement>, String>((ref, productId) {
      return ref.watch(inventoryRepositoryProvider).watchMovements(productId);
    });
