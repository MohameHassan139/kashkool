import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/pdf/pdf_reports_service.dart';
import 'package:kashkool/features/inventory/domain/product_with_stock.dart';
import 'package:kashkool/features/reports/domain/profit_loss_report.dart';
import 'package:kashkool/features/reports/domain/shop_financial_overview.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PdfReportsService service;

  setUp(() {
    service = PdfReportsService();
  });

  group('PdfReportsService - Report and Invoice Generation', () {
    test('generateProfitLossPdf generates valid non-empty PDF bytes', () async {
      final report = ProfitLossReport(
        period: ReportPeriod.today,
        startDate: DateTime.fromMillisecondsSinceEpoch(1700000000000),
        endDate: DateTime.fromMillisecondsSinceEpoch(1700086400000),
        cashRevenuePiasters: 150000,
        cashCogsPiasters: 100000,
        cashGrossProfitPiasters: 50000,
        cashNetProfitPiasters: 40000,
        creditRevenuePiasters: 80000,
        creditCogsPiasters: 50000,
        creditGrossProfitPiasters: 30000,
        totalRevenuePiasters: 230000,
        costOfGoodsSoldPiasters: 150000,
        grossProfitPiasters: 80000,
        operatingExpensesPiasters: 10000,
        netProfitPiasters: 70000,
        profitMarginPercentage: 34.8,
        totalSalesCount: 15,
        cashSalesCount: 10,
        creditSalesCount: 5,
        totalExpensesCount: 2,
      );

      final a4Bytes = await service.generateProfitLossPdf(
        report: report,
        shopName: 'بقالة الأمانة',
        shopPhone: '01012345678',
        format: PdfDocumentFormat.a4,
      );

      expect(a4Bytes, isNotEmpty);
      expect(a4Bytes.length, greaterThan(1000));

      final thermalBytes = await service.generateProfitLossPdf(
        report: report,
        shopName: 'بقالة الأمانة',
        format: PdfDocumentFormat.thermal80mm,
      );

      expect(thermalBytes, isNotEmpty);
      expect(thermalBytes.length, greaterThan(1000));
    });

    test('generateShopOverviewPdf generates valid PDF bytes', () async {
      final overview = ShopFinancialOverview(
        generatedAt: DateTime.now(),
        inventoryCostPiasters: 500000,
        inventoryRetailPiasters: 750000,
        inventoryExpectedProfitPiasters: 250000,
        totalProductCount: 45,
        lowStockCount: 4,
        customerReceivablesPiasters: 120000,
        customerDebtCount: 8,
        supplierPayablesPiasters: 90000,
        supplierDebtCount: 3,
        cashInDrawerPiasters: 35000,
        digitalBalancePiasters: 15000,
        totalCashAndBankPiasters: 50000,
        netWorthPiasters: 580000,
      );

      final bytes = await service.generateShopOverviewPdf(
        overview: overview,
        shopName: 'سوبرماركت التحرير',
        shopPhone: '01123456789',
      );

      expect(bytes, isNotEmpty);
      expect(bytes.length, greaterThan(1000));
    });

    test('generateInventoryReportPdf generates low-stock and full inventory PDFs', () async {
      final product1 = Product(
        id: 'p1',
        shopId: 'shop-1',
        deviceId: 'dev-1',
        createdBy: 'user-1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        name: 'شاي العروسة 250جم',
        barcode: '123456',
        unitLabel: 'علبة',
        purchasePricePiasters: 4500,
        salePricePiasters: 5500,
        minimumStockMilliUnits: 5000,
      );

      final supplier = Supplier(
        id: 's1',
        shopId: 'shop-1',
        deviceId: 'dev-1',
        createdBy: 'user-1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        name: 'شركة الشاي والتوزيع',
        phone: '01009988776',
      );

      final items = [
        ProductWithStock(
          product: product1,
          quantityMilliUnits: 2000, // Deficit: 2000 <= 5000 (Low stock)
          supplier: supplier,
        ),
      ];

      // Low stock report
      final lowStockBytes = await service.generateInventoryReportPdf(
        products: items,
        shopName: 'محل البركة',
        isLowStockOnly: true,
      );
      expect(lowStockBytes, isNotEmpty);

      // Full inventory report
      final fullBytes = await service.generateInventoryReportPdf(
        products: items,
        shopName: 'محل البركة',
        isLowStockOnly: false,
      );
      expect(fullBytes, isNotEmpty);
    });

    test('generateSaleInvoicePdf generates thermal receipt and A4 invoice', () async {
      final now = DateTime.now();
      final sale = Sale(
        id: 'sale-abc-12345678',
        shopId: 'shop-1',
        deviceId: 'dev-1',
        createdBy: 'user-1',
        createdAt: now,
        updatedAt: now,
        occurredAt: now,
        paymentType: SalePaymentType.cash,
        totalPiasters: 11000,
      );

      final items = [
        SaleItem(
          id: 'item-1',
          shopId: 'shop-1',
          deviceId: 'dev-1',
          createdBy: 'user-1',
          createdAt: now,
          updatedAt: now,
          saleId: sale.id,
          productId: 'p1',
          productName: 'سكر الأسرة 1كجم',
          unitLabel: 'كجم',
          quantityMilliUnits: 2000,
          unitPricePiasters: 3500,
          unitCostPiasters: 3000,
          lineTotalPiasters: 7000,
        ),
        SaleItem(
          id: 'item-2',
          shopId: 'shop-1',
          deviceId: 'dev-1',
          createdBy: 'user-1',
          createdAt: now,
          updatedAt: now,
          saleId: sale.id,
          productId: 'p2',
          productName: 'زيت ذرة 800مل',
          unitLabel: 'زجاجة',
          quantityMilliUnits: 1000,
          unitPricePiasters: 4000,
          unitCostPiasters: 3600,
          lineTotalPiasters: 4000,
        ),
      ];

      final thermalBytes = await service.generateSaleInvoicePdf(
        sale: sale,
        items: items,
        shopName: 'ماركت السلام',
        shopPhone: '01234567890',
        format: PdfDocumentFormat.thermal80mm,
      );

      expect(thermalBytes, isNotEmpty);
      expect(thermalBytes.length, greaterThan(800));

      final a4Bytes = await service.generateSaleInvoicePdf(
        sale: sale,
        items: items,
        shopName: 'ماركت السلام',
        format: PdfDocumentFormat.a4,
      );

      expect(a4Bytes, isNotEmpty);
      expect(a4Bytes.length, greaterThan(1000));
    });
  });
}
