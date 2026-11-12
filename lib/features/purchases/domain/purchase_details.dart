import '../../../core/db/app_database.dart';

class PurchaseLineInput {
  final String productId;
  final int quantityMilliUnits;
  final int unitCostPiasters;

  const PurchaseLineInput({
    required this.productId,
    required this.quantityMilliUnits,
    required this.unitCostPiasters,
  });
}

class PurchaseItemWithReturns {
  final PurchaseItem item;
  final int returnedQuantityMilliUnits;

  const PurchaseItemWithReturns({
    required this.item,
    required this.returnedQuantityMilliUnits,
  });

  int get remainingQuantityMilliUnits =>
      item.quantityMilliUnits - returnedQuantityMilliUnits;
}

class PurchaseDetails {
  final PurchaseInvoice invoice;
  final List<PurchaseItemWithReturns> items;

  const PurchaseDetails({required this.invoice, required this.items});
}
