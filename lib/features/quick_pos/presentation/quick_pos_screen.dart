import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/credit_limit.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/quantity.dart';
import '../../../features/customers/domain/customer_with_balance.dart';
import '../../../features/customers/presentation/add_edit_customer_screen.dart';
import '../../../features/inventory/domain/product_with_stock.dart';
import '../../../features/inventory/data/inventory_repository.dart';
import '../../../l10n/l10n.dart';
import '../data/sale_repository.dart';
import 'quick_pos_providers.dart';

class QuickPosScreen extends ConsumerStatefulWidget {
  const QuickPosScreen({super.key});

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _addProduct(ProductWithStock product) async {
    final existing = _cart[product.product.id]?.quantityMilliUnits ?? 0;
    final remaining = product.quantityMilliUnits - existing;
    if (remaining <= 0) {
      _showMessage(L10n.t.quickPosInsufficientStock);
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

  Future<void> _editQuantity(_CartLine line) async {
    final quantity = await _askQuantity(
      line.product,
      initialMilliUnits: line.quantityMilliUnits,
      maxMilliUnits: line.product.quantityMilliUnits,
    );
    if (quantity == null || !mounted) return;
    setState(() {
      _cart[line.product.product.id] = _CartLine(
        product: line.product,
        quantityMilliUnits: quantity,
      );
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
        _showMessage(L10n.t.quickPosCustomerRequired);
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
              builder: (_) =>
                  AddEditCustomerScreen(customer: customer!.customer),
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
      await ref
          .read(saleRepositoryProvider)
          .createSale(
            paymentType: _paymentType,
            customerId: _paymentType == SalePaymentType.credit
                ? customer!.customer.id
                : null,
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
      _showMessage(L10n.t.quickPosSaleSaved);
    } on ArgumentError catch (error, stackTrace) {
      debugPrint('Quick sale validation failed: $error\n$stackTrace');
      if (!mounted) return;
      _showMessage(L10n.t.quickPosInsufficientStock);
    } on StateError catch (error, stackTrace) {
      debugPrint('Quick sale could not be completed: $error\n$stackTrace');
      if (!mounted) return;
      final isClosedDay = error.message.toString().contains('closed');
      _showMessage(
        isClosedDay ? L10n.t.quickPosCashDayClosed : L10n.t.quickPosSaveFailed,
      );
    } catch (error, stackTrace) {
      debugPrint('Unexpected quick sale error: $error\n$stackTrace');
      if (!mounted) return;
      _showMessage(L10n.t.quickPosSaveFailed);
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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
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

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(_quickPosProductListProvider(_query));
    final customersAsync = ref.watch(quickPosCustomerListProvider);
    final strings = L10n.t;

    return Scaffold(
      appBar: AppBar(title: Text(strings.quickPosTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: strings.quickPosSearch,
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                      icon: const Icon(Icons.clear_rounded),
                    ),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            strings.quickPosProducts,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: productsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text(strings.quickPosLoadFailed)),
              data: (products) {
                if (products.isEmpty) {
                  return Center(
                    child: Text(
                      _query.trim().isEmpty
                          ? strings.inventoryNoProducts
                          : strings.inventoryNoSearchResults,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final inCart =
                        _cart[product.product.id]?.quantityMilliUnits ?? 0;
                    final available = product.quantityMilliUnits - inCart;
                    return Card(
                      child: ListTile(
                        title: Text(product.product.name),
                        subtitle: Text(
                          '${MoneyUtils.formatMoney(product.product.salePricePiasters)} · '
                          '${strings.quickPosAvailable}: '
                          '${QuantityUtils.formatMilliUnits(available)} '
                          '${product.product.unitLabel}',
                        ),
                        trailing: IconButton(
                          tooltip: strings.quickPosAdd,
                          onPressed: available <= 0
                              ? null
                              : () => _addProduct(product),
                          icon: const Icon(Icons.add_shopping_cart_rounded),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            strings.quickPosCart,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (_cart.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(child: Text(strings.quickPosEmptyCart)),
            )
          else
            ..._cart.values.map(
              (line) => Card(
                child: ListTile(
                  onTap: () => _editQuantity(line),
                  title: Text(line.product.product.name),
                  subtitle: Text(
                    '${QuantityUtils.formatMilliUnits(line.quantityMilliUnits)} '
                    '${line.product.product.unitLabel} · '
                    '${MoneyUtils.formatMoney(SaleRepository.calculateLineTotalPiasters(quantityMilliUnits: line.quantityMilliUnits, unitPricePiasters: line.product.product.salePricePiasters))}',
                  ),
                  trailing: IconButton(
                    tooltip: strings.delete,
                    onPressed: () =>
                        setState(() => _cart.remove(line.product.product.id)),
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          SegmentedButton<SalePaymentType>(
            segments: [
              ButtonSegment(
                value: SalePaymentType.cash,
                label: Text(strings.quickPosCash),
                icon: const Icon(Icons.payments_outlined),
              ),
              ButtonSegment(
                value: SalePaymentType.credit,
                label: Text(strings.quickPosCredit),
                icon: const Icon(Icons.account_balance_wallet_outlined),
              ),
            ],
            selected: {_paymentType},
            onSelectionChanged: (value) {
              setState(() {
                _paymentType = value.first;
                if (_paymentType == SalePaymentType.cash) _customerId = null;
              });
            },
          ),
          if (_paymentType == SalePaymentType.credit) ...[
            const SizedBox(height: 12),
            customersAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, stackTrace) =>
                  Text(strings.quickPosCustomersLoadFailed),
              data: (customers) {
                final selectedId =
                    customers.any(
                      (customer) => customer.customer.id == _customerId,
                    )
                    ? _customerId
                    : null;
                return DropdownButtonFormField<String>(
                  initialValue: selectedId,
                  decoration: InputDecoration(
                    labelText: strings.quickPosSelectCustomer,
                    border: const OutlineInputBorder(),
                  ),
                  items: customers
                      .map(
                        (customer) => DropdownMenuItem(
                          value: customer.customer.id,
                          child: Text(customer.customer.name),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: (value) => setState(() => _customerId = value),
                );
              },
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                strings.quickPosTotal,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                MoneyUtils.formatMoney(_totalPiasters),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _cart.isEmpty || _saving
                ? null
                : _paymentType == SalePaymentType.cash
                ? () => _checkout(const [])
                : customersAsync.whenOrNull(
                    data: (customers) =>
                        () => _checkout(customers),
                  ),
            icon: _saving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check_circle_outline_rounded),
            label: Text(
              _saving ? strings.quickPosSaving : strings.quickPosCompleteSale,
            ),
          ),
        ],
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
