import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/quantity.dart';
import '../../../l10n/l10n.dart';
import '../data/inventory_repository.dart';
import '../domain/product_with_stock.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  final ProductWithStock? product;

  const ProductFormScreen({super.key, this.product});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _barcodeController;
  late final TextEditingController _categoryController;
  late final TextEditingController _unitController;
  late final TextEditingController _purchasePriceController;
  late final TextEditingController _salePriceController;
  late final TextEditingController _minimumStockController;
  late final TextEditingController _initialStockController;
  bool _saving = false;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    final product = widget.product?.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _barcodeController = TextEditingController(text: product?.barcode ?? '');
    _categoryController = TextEditingController(text: product?.category ?? '');
    _unitController = TextEditingController(text: product?.unitLabel ?? '');
    _purchasePriceController = TextEditingController(
      text: product == null
          ? ''
          : MoneyUtils.formatMoney(
              product.purchasePricePiasters,
              includeCurrency: false,
            ),
    );
    _salePriceController = TextEditingController(
      text: product == null
          ? ''
          : MoneyUtils.formatMoney(
              product.salePricePiasters,
              includeCurrency: false,
            ),
    );
    _minimumStockController = TextEditingController(
      text: product == null
          ? '0'
          : QuantityUtils.formatMilliUnits(product.minimumStockMilliUnits),
    );
    _initialStockController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _categoryController.dispose();
    _unitController.dispose();
    _purchasePriceController.dispose();
    _salePriceController.dispose();
    _minimumStockController.dispose();
    _initialStockController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repository = ref.read(inventoryRepositoryProvider);
    try {
      final purchasePrice = MoneyUtils.toPiasters(
        _purchasePriceController.text,
        fallback: -1,
      );
      final salePrice = MoneyUtils.toPiasters(
        _salePriceController.text,
        fallback: -1,
      );
      final minimumStock =
          QuantityUtils.parseMilliUnits(_minimumStockController.text) ?? 0;

      if (_isEditing) {
        await repository.updateProduct(
          id: widget.product!.product.id,
          name: _nameController.text,
          unitLabel: _unitController.text,
          purchasePricePiasters: purchasePrice,
          salePricePiasters: salePrice,
          minimumStockMilliUnits: minimumStock,
          barcode: _barcodeController.text,
          category: _categoryController.text,
        );
      } else {
        final startingStock = _initialStockController.text.trim().isEmpty
            ? 0
            : QuantityUtils.parseMilliUnits(_initialStockController.text) ?? -1;
        if (startingStock < 0) {
          _showMessage(L10n.t.inventoryInvalidQuantity);
          return;
        }
        await repository.addProduct(
          name: _nameController.text,
          unitLabel: _unitController.text,
          purchasePricePiasters: purchasePrice,
          salePricePiasters: salePrice,
          minimumStockMilliUnits: minimumStock,
          barcode: _barcodeController.text,
          category: _categoryController.text,
          startingStockMilliUnits: startingStock,
        );
      }

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      final message = error.toString();
      if (message.contains('Barcode already exists')) {
        _showMessage(L10n.t.inventoryBarcodeExists);
      } else if (message.contains('Cannot change a product unit')) {
        _showMessage(L10n.t.inventoryUnitChangeNotAllowed);
      } else {
        _showMessage(L10n.t.inventorySaveFailed);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String? _required(String? value, String message) =>
      value == null || value.trim().isEmpty ? message : null;

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return L10n.t.inventoryInvalidPrice;
    }
    return MoneyUtils.toPiasters(value, fallback: -1) < 0
        ? L10n.t.inventoryInvalidPrice
        : null;
  }

  String? _validateQuantity(String? value, {bool allowEmpty = false}) {
    if (allowEmpty && (value == null || value.trim().isEmpty)) return null;
    final quantity = value == null
        ? null
        : QuantityUtils.parseMilliUnits(value);
    return quantity == null || quantity < 0
        ? L10n.t.inventoryInvalidQuantity
        : null;
  }

  InputDecoration _decoration(String label, {String? hint}) => InputDecoration(
    labelText: label,
    hintText: hint,
    border: const OutlineInputBorder(),
  );

  @override
  Widget build(BuildContext context) {
    final strings = L10n.t;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? strings.inventoryEditProduct
              : strings.inventoryAddProduct,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: _decoration(strings.inventoryProductName),
              textCapitalization: TextCapitalization.sentences,
              maxLength: 100,
              validator: (value) =>
                  _required(value, strings.inventoryNameRequired),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _barcodeController,
              decoration: _decoration(strings.inventoryBarcode),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _categoryController,
              decoration: _decoration(strings.inventoryCategory),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _unitController,
              decoration: _decoration(
                strings.inventoryUnit,
                hint: strings.inventoryUnitExample,
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLength: 24,
              validator: (value) =>
                  _required(value, strings.inventoryUnitRequired),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _purchasePriceController,
              decoration: _decoration(strings.inventoryPurchasePrice),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d٠-٩٫., ]')),
              ],
              validator: _validatePrice,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _salePriceController,
              decoration: _decoration(strings.inventorySalePrice),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d٠-٩٫., ]')),
              ],
              validator: _validatePrice,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _minimumStockController,
              decoration: _decoration(strings.inventoryMinimumStock),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d٠-٩٫,]')),
              ],
              validator: _validateQuantity,
            ),
            if (!_isEditing) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _initialStockController,
                decoration: _decoration(strings.inventoryInitialStock),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d٠-٩٫,]')),
                ],
                validator: (value) =>
                    _validateQuantity(value, allowEmpty: true),
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
                  : Text(strings.inventorySave),
            ),
          ],
        ),
      ),
    );
  }
}
