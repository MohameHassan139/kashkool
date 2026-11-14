import '../../../core/db/app_database.dart';

class ProductWithStock {
  final Product product;
  final int quantityMilliUnits;
  final Supplier? supplier;

  const ProductWithStock({
    required this.product,
    required this.quantityMilliUnits,
    this.supplier,
  });

  bool get isLowStock => quantityMilliUnits <= product.minimumStockMilliUnits;
}
