import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../features/inventory/data/inventory_repository.dart';
import '../../../features/inventory/domain/product_with_stock.dart';
import '../data/purchase_repository.dart';
import '../domain/purchase_details.dart';

final supplierPurchasesProvider =
    StreamProvider.family<List<PurchaseInvoice>, String>((ref, supplierId) {
      return ref.watch(purchaseRepositoryProvider).watchPurchases(supplierId);
    });

final purchaseDetailsProvider = FutureProvider.family<PurchaseDetails?, String>(
  (ref, purchaseId) {
    return ref.watch(purchaseRepositoryProvider).getPurchaseDetails(purchaseId);
  },
);

final purchaseProductListProvider = StreamProvider<List<ProductWithStock>>((
  ref,
) {
  return ref.watch(inventoryRepositoryProvider).watchProducts();
});
