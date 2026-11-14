/// Comprehensive financial and inventory overview of the entire shop.
class ShopFinancialOverview {
  final DateTime generatedAt;

  // 1. Inventory Valuation
  final int inventoryCostPiasters;
  final int inventoryRetailPiasters;
  final int inventoryExpectedProfitPiasters;
  final int totalProductCount;
  final int lowStockCount;

  // 2. Receivables from customers ("لينا عند الناس")
  final int customerReceivablesPiasters;
  final int customerDebtCount;

  // 3. Payables to suppliers ("علينا للموردين")
  final int supplierPayablesPiasters;
  final int supplierDebtCount;

  // 4. Cash in Hand & Drawer
  final int cashInDrawerPiasters;
  final int digitalBalancePiasters;
  final int totalCashAndBankPiasters;

  // 5. Net Shop Worth / Capital (صافي رأس مال المحل)
  // Net Worth = (Inventory At Cost + Cash & Bank + Customer Receivables) - Supplier Payables
  final int netWorthPiasters;

  const ShopFinancialOverview({
    required this.generatedAt,
    required this.inventoryCostPiasters,
    required this.inventoryRetailPiasters,
    required this.inventoryExpectedProfitPiasters,
    required this.totalProductCount,
    required this.lowStockCount,
    required this.customerReceivablesPiasters,
    required this.customerDebtCount,
    required this.supplierPayablesPiasters,
    required this.supplierDebtCount,
    required this.cashInDrawerPiasters,
    required this.digitalBalancePiasters,
    required this.totalCashAndBankPiasters,
    required this.netWorthPiasters,
  });
}
