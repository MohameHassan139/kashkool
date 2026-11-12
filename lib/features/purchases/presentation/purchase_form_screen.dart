import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/quantity.dart';
import '../../../features/inventory/domain/product_with_stock.dart';
import '../../../l10n/l10n.dart';
import '../data/purchase_repository.dart';
import '../domain/purchase_details.dart';
import 'purchase_providers.dart';

class PurchaseFormScreen extends ConsumerStatefulWidget {
  final String supplierId;
  final String supplierName;

  const PurchaseFormScreen({
    super.key,
    required this.supplierId,
    required this.supplierName,
  });

  @override
  ConsumerState<PurchaseFormScreen> createState() => _PurchaseFormScreenState();
}

class _PurchaseFormScreenState extends ConsumerState<PurchaseFormScreen> {
  final _invoiceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitCostController = TextEditingController();
  final _lines = <PurchaseLineInputWithProduct>[];
  String? _selectedProductId;
  PurchasePaymentType _paymentType = PurchasePaymentType.credit;
  String? _errorMessage;
  bool _saving = false;

  @override
  void dispose() {
    _invoiceController.dispose();
    _quantityController.dispose();
    _unitCostController.dispose();
    super.dispose();
  }

  ProductWithStock? _selectedProduct(List<ProductWithStock> products) {
    for (final product in products) {
      if (product.product.id == _selectedProductId) return product;
    }
    return null;
  }

  void _selectProduct(String? productId, List<ProductWithStock> products) {
    setState(() {
      _selectedProductId = productId;
      final selected = _selectedProduct(products);
      _unitCostController.text = selected == null
          ? ''
          : MoneyUtils.formatMoney(
              selected.product.purchasePricePiasters,
              includeCurrency: false,
            );
    });
  }

  void _addLine(ProductWithStock? product) {
    final quantity = QuantityUtils.parseMilliUnits(_quantityController.text);
    final cost = MoneyUtils.toPiasters(_unitCostController.text, fallback: -1);
    if (product == null || quantity == null || quantity <= 0 || cost < 0) {
      setState(() => _errorMessage = L10n.t.supplierPurchaseInvalidInput);
      return;
    }

    setState(() {
      _lines.add(
        PurchaseLineInputWithProduct(
          product: product,
          line: PurchaseLineInput(
            productId: product.product.id,
            quantityMilliUnits: quantity,
            unitCostPiasters: cost,
          ),
        ),
      );
      _quantityController.clear();
      _errorMessage = null;
    });
  }

  int _lineTotal(PurchaseLineInput line) =>
      PurchaseRepository.calculateLineTotalPiasters(
        quantityMilliUnits: line.quantityMilliUnits,
        unitCostPiasters: line.unitCostPiasters,
      );

  Future<void> _save() async {
    if (_lines.isEmpty) {
      setState(() => _errorMessage = L10n.t.supplierPurchaseNoLines);
      return;
    }

    setState(() {
      _saving = true;
      _errorMessage = null;
    });
    try {
      await ref
          .read(purchaseRepositoryProvider)
          .createPurchase(
            supplierId: widget.supplierId,
            paymentType: _paymentType,
            lines: _lines.map((item) => item.line).toList(growable: false),
            invoiceNumber: _invoiceController.text,
          );
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorMessage = L10n.t.supplierPurchaseSaveFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(purchaseProductListProvider);
    final strings = L10n.t;
    final total = _lines.fold<int>(
      0,
      (sum, line) => sum + _lineTotal(line.line),
    );

    return Scaffold(
      appBar: AppBar(title: Text(strings.supplierPurchaseNew)),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text(strings.supplierPurchaseLoadError)),
        data: (products) {
          final selectedProduct = _selectedProduct(products);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                widget.supplierName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _invoiceController,
                decoration: InputDecoration(
                  labelText: strings.supplierPurchaseInvoiceNumber,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                strings.supplierPurchasePaymentType,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              SegmentedButton<PurchasePaymentType>(
                segments: [
                  ButtonSegment(
                    value: PurchasePaymentType.cash,
                    label: Text(strings.supplierPurchaseCash),
                    icon: const Icon(Icons.payments_outlined),
                  ),
                  ButtonSegment(
                    value: PurchasePaymentType.credit,
                    label: Text(strings.supplierPurchaseCredit),
                    icon: const Icon(Icons.event_note_outlined),
                  ),
                ],
                selected: {_paymentType},
                onSelectionChanged: (value) =>
                    setState(() => _paymentType = value.first),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _selectedProductId,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: strings.supplierPurchaseAddProduct,
                  border: const OutlineInputBorder(),
                ),
                items: products
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item.product.id,
                        child: Text(
                          '${item.product.name} · '
                          '${QuantityUtils.formatMilliUnits(item.quantityMilliUnits)} '
                          '${item.product.unitLabel}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => _selectProduct(value, products),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[\d٠-٩٫,]')),
                      ],
                      decoration: InputDecoration(
                        labelText: strings.supplierPurchaseQuantity,
                        suffixText: selectedProduct?.product.unitLabel,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _unitCostController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[\d٠-٩٫., ]'),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: strings.supplierPurchaseUnitCost,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: products.isEmpty
                    ? null
                    : () => _addLine(selectedProduct),
                icon: const Icon(Icons.add_rounded),
                label: Text(strings.supplierPurchaseAddLine),
              ),
              if (products.isEmpty) ...[
                const SizedBox(height: 8),
                Text(L10n.t.inventoryNoProducts, textAlign: TextAlign.center),
              ],
              if (_lines.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  strings.supplierPurchaseItems,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._lines.indexed.map((entry) {
                  final index = entry.$1;
                  final line = entry.$2;
                  return Card(
                    child: ListTile(
                      title: Text(line.product.product.name),
                      subtitle: Text(
                        '${QuantityUtils.formatMilliUnits(line.line.quantityMilliUnits)} '
                        '${line.product.product.unitLabel} × '
                        '${MoneyUtils.formatMoney(line.line.unitCostPiasters)}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            MoneyUtils.formatMoney(_lineTotal(line.line)),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            tooltip: strings.delete,
                            onPressed: () =>
                                setState(() => _lines.removeAt(index)),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
              const SizedBox(height: 12),
              Text(
                '${strings.supplierPurchaseTotal}: ${MoneyUtils.formatMoney(total)}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(strings.supplierPurchaseSave),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PurchaseLineInputWithProduct {
  final ProductWithStock product;
  final PurchaseLineInput line;

  const PurchaseLineInputWithProduct({
    required this.product,
    required this.line,
  });
}
