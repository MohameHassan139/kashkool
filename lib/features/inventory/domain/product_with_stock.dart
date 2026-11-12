import '../../../core/db/app_database.dart';

class ProductWithStock {
  final Product product;
  final int quantityMilliUnits;

  const ProductWithStock({
    required this.product,
    required this.quantityMilliUnits,
  });

  bool get isLowStock => quantityMilliUnits <= product.minimumStockMilliUnits;
}
