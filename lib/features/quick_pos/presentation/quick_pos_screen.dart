import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/credit_limit.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/quantity.dart';
import '../../../features/customers/domain/customer_with_balance.dart';
import '../../../features/customers/presentation/add_edit_customer_screen.dart';
import '../../../features/customers/presentation/widgets/rating_badge.dart';
import '../../../features/inventory/domain/product_with_stock.dart';
import '../../../features/inventory/data/inventory_repository.dart';
import '../../../features/inventory/presentation/inventory_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../data/sale_repository.dart';
import 'quick_pos_providers.dart';

/// Point of Sale / Quick Pay Screen (نقطة البيع والدفع السريع).
class QuickPosScreen extends ConsumerStatefulWidget {
  final String? initialCustomerId;

  const QuickPosScreen({super.key, this.initialCustomerId});

  @override
  ConsumerState<QuickPosScreen> createState() => _QuickPosScreenState();
}

class _QuickPosScreenState extends ConsumerState<QuickPosScreen> {
  final _searchController = TextEditingController();
  final _cart = <String, _CartLine>{};
  String _query = '';
  String? _customerId;
  SalePaymentType _paymentType = SalePaymentType.cash;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialCustomerId != null) {
      _customerId = widget.initialCustomerId;
      _paymentType = SalePaymentType.credit;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onProductTapped(ProductWithStock product) {
    final existing = _cart[product.product.id]?.quantityMilliUnits ?? 0;
    final remaining = product.quantityMilliUnits - existing;
    if (remaining <= 0) {
      _showMessage(L10n.t.quickPosInsufficientStock, isError: true);
      return;
    }

    // If unit is fractional (e.g. kg, liter) or remaining < 1000 milli-units, open quantity dialog
    final isFractional = const {'kg', 'كيلو', 'لتر', 'متر', 'جرام', 'gram'}.contains(product.product.unitLabel.toLowerCase());
    if (isFractional || remaining < 1000) {
      _addProductWithQuantity(product);
      return;
    }

    // Otherwise quick add 1 unit (1000 milli-units)
    HapticFeedback.lightImpact();
    setState(() {
      final oldLine = _cart[product.product.id];
      _cart[product.product.id] = _CartLine(
        product: product,
        quantityMilliUnits: (oldLine?.quantityMilliUnits ?? 0) + 1000,
      );
    });
  }

  Future<void> _addProductWithQuantity(ProductWithStock product) async {
    final existing = _cart[product.product.id]?.quantityMilliUnits ?? 0;
    final remaining = product.quantityMilliUnits - existing;
    if (remaining <= 0) {
      _showMessage(L10n.t.quickPosInsufficientStock, isError: true);
      return;
    }

    final quantity = await _askQuantity(
      product,
      initialMilliUnits: remaining < 1000 ? remaining : 1000,
      maxMilliUnits: remaining,
    );
    if (quantity == null || !mounted) return;

    setState(() {
      final oldLine = _cart[product.product.id];
      _cart[product.product.id] = _CartLine(
        product: product,
        quantityMilliUnits: (oldLine?.quantityMilliUnits ?? 0) + quantity,
      );
    });
  }

  void _incrementQuantity(_CartLine line) {
    final remaining = line.product.quantityMilliUnits - line.quantityMilliUnits;
    if (remaining <= 0) {
      _showMessage(L10n.t.quickPosInsufficientStock, isError: true);
      return;
    }
    final step = remaining >= 1000 ? 1000 : remaining;
    HapticFeedback.selectionClick();
    setState(() {
      _cart[line.product.product.id] = _CartLine(
        product: line.product,
        quantityMilliUnits: line.quantityMilliUnits + step,
      );
    });
  }

  void _decrementQuantity(_CartLine line) {
    HapticFeedback.selectionClick();
    setState(() {
      if (line.quantityMilliUnits <= 1000) {
        _cart.remove(line.product.product.id);
      } else {
        _cart[line.product.product.id] = _CartLine(
          product: line.product,
          quantityMilliUnits: line.quantityMilliUnits - 1000,
        );
      }
    });
  }

  Future<void> _editQuantity(_CartLine line) async {
    final quantity = await _askQuantity(
      line.product,
      initialMilliUnits: line.quantityMilliUnits,
      maxMilliUnits: line.product.quantityMilliUnits,
    );
    if (quantity == null || !mounted) return;
    setState(() {
      if (quantity <= 0) {
        _cart.remove(line.product.product.id);
      } else {
        _cart[line.product.product.id] = _CartLine(
          product: line.product,
          quantityMilliUnits: quantity,
        );
      }
    });
  }

  Future<int?> _askQuantity(
    ProductWithStock product, {
    required int initialMilliUnits,
    required int maxMilliUnits,
  }) {
    return showDialog<int>(
      context: context,
      builder: (context) => _QuantityDialog(
        product: product,
        initialMilliUnits: initialMilliUnits,
        maxMilliUnits: maxMilliUnits,
      ),
    );
  }

  void _onBarcodeSubmitted(String barcode, List<ProductWithStock> products) {
    final code = barcode.trim();
    if (code.isEmpty) return;
    ProductWithStock? match;
    for (final p in products) {
      if (p.product.barcode != null && p.product.barcode!.trim() == code) {
        match = p;
        break;
      }
    }
    if (match != null) {
      _onProductTapped(match);
      _searchController.clear();
      setState(() => _query = '');
    }
  }

  Future<void> _checkout(List<CustomerWithBalance> customers) async {
    if (_saving || _cart.isEmpty) return;

    CustomerWithBalance? customer;
    if (_paymentType == SalePaymentType.credit) {
      for (final item in customers) {
        if (item.customer.id == _customerId) {
          customer = item;
          break;
        }
      }
      if (customer == null) {
        _showMessage(L10n.t.quickPosCustomerRequired, isError: true);
        return;
      }

      final total = _totalPiasters;
      final limit = customer.customer.creditLimitPiasters;
      if (CreditLimitUtils.willExceed(
        currentBalancePiasters: customer.balancePiasters,
        addedDebtPiasters: total,
        limitPiasters: limit,
      )) {
        final action = await _showCreditLimitWarning(customer, total, limit!);
        if (!mounted || action == 'cancel') return;
        if (action == 'change_limit') {
          await Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (_) => AddEditCustomerScreen(customer: customer!.customer),
            ),
          );
          ref.invalidate(quickPosCustomerListProvider);
          return;
        }
        if (action != 'save_anyway') return;
      }
    }

    setState(() => _saving = true);
    try {
      await ref.read(saleRepositoryProvider).createSale(
            paymentType: _paymentType,
            customerId: _paymentType == SalePaymentType.credit ? customer!.customer.id : null,
            lines: _cart.values
                .map(
                  (line) => SaleLineInput(
                    productId: line.product.product.id,
                    quantityMilliUnits: line.quantityMilliUnits,
                  ),
                )
                .toList(growable: false),
          );
      if (!mounted) return;
      setState(() {
        _cart.clear();
        _customerId = null;
      });
      AppGlassToast.showSuccess(context, L10n.t.quickPosSaleSaved);
    } on ArgumentError catch (error, stackTrace) {
      debugPrint('Quick sale validation failed: $error\n$stackTrace');
      if (!mounted) return;
      _showMessage(L10n.t.quickPosInsufficientStock, isError: true);
    } on StateError catch (error, stackTrace) {
      debugPrint('Quick sale could not be completed: $error\n$stackTrace');
      if (!mounted) return;
      final isClosedDay = error.message.toString().contains('closed');
      _showMessage(
        isClosedDay ? L10n.t.quickPosCashDayClosed : L10n.t.quickPosSaveFailed,
        isError: true,
      );
    } catch (error, stackTrace) {
      debugPrint('Unexpected quick sale error: $error\n$stackTrace');
      if (!mounted) return;
      _showMessage(L10n.t.quickPosSaveFailed, isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<String?> _showCreditLimitWarning(
    CustomerWithBalance customer,
    int totalPiasters,
    int limitPiasters,
  ) {
    final strings = L10n.t;
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.creditLimitWarningTitle),
        content: Text(
          strings.creditLimitExceededDialog(
            customer.customer.name,
            MoneyUtils.formatMoney(customer.balancePiasters + totalPiasters),
            MoneyUtils.formatMoney(limitPiasters),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop('cancel'),
            child: Text(strings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop('change_limit'),
            child: Text(strings.changeLimit),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop('save_anyway'),
            child: Text(strings.saveAnyway),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message, {bool isError = false}) {
    if (isError) {
      AppGlassToast.showError(context, message);
    } else {
      AppGlassToast.show(context, message: message);
    }
  }

  int get _totalPiasters => _cart.values.fold<int>(
        0,
        (total, line) =>
            total +
            SaleRepository.calculateLineTotalPiasters(
              quantityMilliUnits: line.quantityMilliUnits,
              unitPricePiasters: line.product.product.salePricePiasters,
            ),
      );

  int get _totalItemsCount => _cart.values.fold<int>(
        0,
        (count, line) => count + (line.quantityMilliUnits ~/ 1000),
      );

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(_quickPosProductListProvider(_query));
    final customersAsync = ref.watch(quickPosCustomerListProvider);
    final strings = L10n.t;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.quickPosTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_cart.isNotEmpty)
            IconButton(
              tooltip: strings.quickPosEmptyCart,
              icon: const Icon(Icons.delete_sweep_rounded),
              onPressed: () {
                setState(() => _cart.clear());
              },
            ),
          IconButton(
            tooltip: AppLocalizations.of(context)?.navInventory ?? 'المخزون',
            icon: const Icon(Icons.inventory_2_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const InventoryScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Section: Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                onSubmitted: (val) {
                  productsAsync.whenData((products) => _onBarcodeSubmitted(val, products));
                },
                decoration: InputDecoration(
                  hintText: strings.quickPosSearch,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _query.isEmpty
                      ? const Icon(Icons.qr_code_scanner_rounded)
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                          icon: const Icon(Icons.clear_rounded),
                        ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  filled: true,
                  fillColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            // Scrollable Body: Products Catalog & Cart Details
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Products Catalog Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.quickPosProducts,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'اضغط للإضافة',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Products Horizontal/Grid view
                  SizedBox(
                    height: 140,
                    child: productsAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (_, _) => Center(child: Text(strings.quickPosLoadFailed)),
                      data: (products) {
                        if (products.isEmpty) {
                          return Center(
                            child: Text(
                              _query.trim().isEmpty
                                  ? strings.inventoryNoProducts
                                  : strings.inventoryNoSearchResults,
                              style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                            ),
                          );
                        }
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            final inCart = _cart[product.product.id]?.quantityMilliUnits ?? 0;
                            final available = product.quantityMilliUnits - inCart;
                            final isOutOfStock = available <= 0;

                            return InkWell(
                              onTap: isOutOfStock ? null : () => _onProductTapped(product),
                              onLongPress: isOutOfStock ? null : () => _addProductWithQuantity(product),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 140,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: inCart > 0
                                        ? AppColors.paymentGreen
                                        : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                                    width: inCart > 0 ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product.product.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                          ),
                                        ),
                                        if (inCart > 0)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.paymentGreen,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              QuantityUtils.formatMilliUnits(inCart),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          MoneyUtils.formatMoney(product.product.salePricePiasters),
                                          style: TextStyle(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          isOutOfStock
                                              ? 'نفد المخزون'
                                              : '${strings.quickPosAvailable}: ${QuantityUtils.formatMilliUnits(available)} ${product.product.unitLabel}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: isOutOfStock ? AppColors.debtRed : theme.hintColor,
                                            fontWeight: isOutOfStock ? FontWeight.bold : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Cart Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shopping_bag_outlined, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            strings.quickPosCart,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (_cart.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${_cart.length}',
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (_cart.isNotEmpty)
                        Text(
                          '${QuantityUtils.formatMilliUnits(_totalItemsCount * 1000)} صنف',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Cart Items
                  if (_cart.isEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 38,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            strings.quickPosEmptyCart,
                            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    )
                  else
                    ..._cart.values.map(
                      (line) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      line.product.product.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${MoneyUtils.formatMoney(line.product.product.salePricePiasters)} / ${line.product.product.unitLabel}',
                                      style: TextStyle(color: theme.hintColor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              // Inline Stepper [-] [quantity] [+]
                              Container(
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(4),
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      icon: const Icon(Icons.remove_rounded),
                                      onPressed: () => _decrementQuantity(line),
                                    ),
                                    InkWell(
                                      onTap: () => _editQuantity(line),
                                      borderRadius: BorderRadius.circular(8),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: Text(
                                          QuantityUtils.formatMilliUnits(line.quantityMilliUnits),
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(4),
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      icon: const Icon(Icons.add_rounded),
                                      onPressed: line.quantityMilliUnits < line.product.quantityMilliUnits
                                          ? () => _incrementQuantity(line)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Line Total
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    MoneyUtils.formatMoney(
                                      SaleRepository.calculateLineTotalPiasters(
                                        quantityMilliUnits: line.quantityMilliUnits,
                                        unitPricePiasters: line.product.product.salePricePiasters,
                                      ),
                                    ),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  IconButton(
                                    iconSize: 18,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                                    icon: Icon(Icons.close_rounded, color: theme.colorScheme.error),
                                    onPressed: () => setState(() => _cart.remove(line.product.product.id)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Payment Type Selection
                  Text(
                    'طريقة السداد',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() {
                            _paymentType = SalePaymentType.cash;
                            _customerId = null;
                          }),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: _paymentType == SalePaymentType.cash
                                  ? AppColors.paymentGreen.withValues(alpha: 0.15)
                                  : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: _paymentType == SalePaymentType.cash
                                    ? AppColors.paymentGreen
                                    : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
                                width: _paymentType == SalePaymentType.cash ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.payments_rounded,
                                  color: _paymentType == SalePaymentType.cash
                                      ? AppColors.paymentGreen
                                      : theme.colorScheme.onSurfaceVariant,
                                  size: 26,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  strings.quickPosCash,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _paymentType == SalePaymentType.cash
                                        ? AppColors.paymentGreen
                                        : theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _paymentType = SalePaymentType.credit),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: _paymentType == SalePaymentType.credit
                                  ? AppColors.debtRed.withValues(alpha: 0.12)
                                  : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: _paymentType == SalePaymentType.credit
                                    ? AppColors.debtRed
                                    : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
                                width: _paymentType == SalePaymentType.credit ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: _paymentType == SalePaymentType.credit
                                      ? AppColors.debtRed
                                      : theme.colorScheme.onSurfaceVariant,
                                  size: 26,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  strings.quickPosCredit,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _paymentType == SalePaymentType.credit
                                        ? AppColors.debtRed
                                        : theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Customer selection when credit sale
                  if (_paymentType == SalePaymentType.credit) ...[
                    const SizedBox(height: 12),
                    customersAsync.when(
                      loading: () => const LinearProgressIndicator(),
                      error: (_, _) => Text(strings.quickPosCustomersLoadFailed),
                      data: (customers) {
                        final selectedCustomer = customers.cast<CustomerWithBalance?>().firstWhere(
                              (c) => c?.customer.id == _customerId,
                              orElse: () => null,
                            );

                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDark ? const Color(0xFF334155) : const Color(0xFFBFDBFE),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      initialValue: selectedCustomer?.customer.id,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        labelText: strings.quickPosSelectCustomer,
                                        border: const OutlineInputBorder(),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      ),
                                      items: customers
                                          .map(
                                            (c) => DropdownMenuItem(
                                              value: c.customer.id,
                                              child: Row(
                                                children: [
                                                  Expanded(child: Text(c.customer.name)),
                                                  Text(
                                                    MoneyUtils.formatMoney(c.balancePiasters),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: c.hasDebt ? AppColors.debtRed : AppColors.paymentGreen,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(growable: false),
                                      onChanged: (value) => setState(() => _customerId = value),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton.filledTonal(
                                    tooltip: 'عميل جديد',
                                    icon: const Icon(Icons.person_add_alt_1_rounded),
                                    onPressed: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const AddEditCustomerScreen(),
                                        ),
                                      );
                                      ref.invalidate(quickPosCustomerListProvider);
                                    },
                                  ),
                                ],
                              ),
                              if (selectedCustomer != null) ...[
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'الرصيد الحالي: ${MoneyUtils.formatMoney(selectedCustomer.balancePiasters)}',
                                      style: TextStyle(
                                        color: selectedCustomer.hasDebt ? AppColors.debtRed : AppColors.paymentGreen,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    CustomerRatingBadge(
                                      customerName: selectedCustomer.customer.name,
                                      rating: selectedCustomer.rating,
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ],

                  const SizedBox(height: 100), // spacing above bottom bar
                ],
              ),
            ),

            // Fixed Sticky Bottom Checkout Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          strings.quickPosTotal,
                          style: TextStyle(color: theme.hintColor, fontSize: 12),
                        ),
                        Text(
                          MoneyUtils.formatMoney(_totalPiasters),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _paymentType == SalePaymentType.cash
                                ? AppColors.paymentGreen
                                : AppColors.debtRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 54,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: _paymentType == SalePaymentType.cash
                            ? AppColors.paymentGreen
                            : theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: _cart.isEmpty || _saving
                          ? null
                          : _paymentType == SalePaymentType.cash
                              ? () => _checkout(const [])
                              : customersAsync.whenOrNull(
                                  data: (customers) => () => _checkout(customers),
                                ),
                      icon: _saving
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Icon(
                              _paymentType == SalePaymentType.cash
                                  ? Icons.check_circle_outline_rounded
                                  : Icons.save_rounded,
                            ),
                      label: Text(
                        _paymentType == SalePaymentType.cash ? 'استلام كاش' : 'تسجيل على الحساب',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartLine {
  final ProductWithStock product;
  final int quantityMilliUnits;

  const _CartLine({required this.product, required this.quantityMilliUnits});
}

class _QuantityDialog extends StatefulWidget {
  final ProductWithStock product;
  final int initialMilliUnits;
  final int maxMilliUnits;

  const _QuantityDialog({
    required this.product,
    required this.initialMilliUnits,
    required this.maxMilliUnits,
  });

  @override
  State<_QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<_QuantityDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: QuantityUtils.formatMilliUnits(widget.initialMilliUnits),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = L10n.t;

    return AlertDialog(
      title: Text(widget.product.product.name),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩.,٫]')),
          ],
          decoration: InputDecoration(
            labelText: strings.quickPosQuantity,
            helperText:
                '${strings.quickPosAvailable}: '
                '${QuantityUtils.formatMilliUnits(widget.maxMilliUnits)} '
                '${widget.product.product.unitLabel}',
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            final quantity = QuantityUtils.parseMilliUnits(value ?? '');
            if (quantity == null || quantity <= 0) {
              return strings.quickPosQuantityInvalid;
            }
            if (quantity > widget.maxMilliUnits) {
              return strings.quickPosInsufficientStock;
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(strings.cancel),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.of(
              context,
            ).pop(QuantityUtils.parseMilliUnits(_controller.text));
          },
          child: Text(strings.save),
        ),
      ],
    );
  }
}

final _quickPosProductListProvider =
    StreamProvider.family<List<ProductWithStock>, String>((ref, query) {
  return ref.watch(inventoryRepositoryProvider).watchProducts(query: query);
});
