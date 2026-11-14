import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/phone.dart';
import '../../../core/utils/quantity.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../../inventory/domain/product_with_stock.dart';
import '../../inventory/presentation/inventory_providers.dart';
import '../../onboarding/data/shop_repository.dart';

/// Interactive dialog for preparing and sending a restocking order
/// directly to the supplier via WhatsApp.
class SupplierRestockDialog extends ConsumerStatefulWidget {
  final Supplier supplier;

  const SupplierRestockDialog({super.key, required this.supplier});

  @override
  ConsumerState<SupplierRestockDialog> createState() =>
      _SupplierRestockDialogState();
}

class _SupplierRestockDialogState
    extends ConsumerState<SupplierRestockDialog> {
  final Map<String, int> _selectedQuantities = {};
  final Set<String> _selectedProductIds = {};
  bool _initialized = false;

  void _initSelections(List<ProductWithStock> products) {
    if (_initialized) return;
    for (final p in products) {
      // Default auto-select items that are low stock
      if (p.isLowStock) {
        _selectedProductIds.add(p.product.id);
        final neededMilliUnits = p.product.minimumStockMilliUnits > p.quantityMilliUnits
            ? (p.product.minimumStockMilliUnits - p.quantityMilliUnits)
            : 1000;
        _selectedQuantities[p.product.id] =
            neededMilliUnits > 0 ? neededMilliUnits : 1000;
      } else {
        _selectedQuantities[p.product.id] = 1000;
      }
    }
    _initialized = true;
  }

  String _buildMessage(String shopName, List<ProductWithStock> products) {
    final buffer = StringBuffer();
    buffer.writeln('السلام عليكم أ/ ${widget.supplier.name} 🌹');
    if (shopName.isNotEmpty) {
      buffer.writeln('معاك محل $shopName.');
    }
    buffer.writeln('محتاجين طلبية بضاعة / نواقص:');
    buffer.writeln();

    for (final p in products) {
      if (_selectedProductIds.contains(p.product.id)) {
        final qtyMilli = _selectedQuantities[p.product.id] ?? 1000;
        final qtyStr = QuantityUtils.formatMilliUnits(qtyMilli);
        buffer.writeln('• ${p.product.name}: $qtyStr ${p.product.unitLabel}');
      }
    }

    buffer.writeln();
    buffer.writeln('برجاء تأكيد استلام الطلبية وميعاد التوريد.');
    buffer.writeln('شكراً لحضرتك 🙏');
    return buffer.toString();
  }

  Future<void> _sendWhatsApp(String message) async {
    final rawPhone = widget.supplier.phone?.trim() ?? '';
    final whatsappPhone = PhoneUtils.toWhatsAppFormat(rawPhone);
    final encoded = Uri.encodeComponent(message);

    if (whatsappPhone != null && whatsappPhone.isNotEmpty) {
      final uri = Uri.parse('https://wa.me/$whatsappPhone?text=$encoded');
      try {
        final launched =
            await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (launched) {
          if (mounted) Navigator.of(context).pop();
          return;
        }
      } catch (_) {}
    }

    // Fallback: copy to clipboard
    await Clipboard.setData(ClipboardData(text: message));
    if (mounted) {
      AppGlassToast.showSuccess(
        context,
        'تم نسخ نص الطلبية بنجاح للحافظة لمشاركتها',
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync =
        ref.watch(supplierProductsStreamProvider(widget.supplier.id));
    final activeShopAsync = ref.watch(activeShopStreamProvider);
    final shopName = activeShopAsync.value?.name ?? '';
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 650),
        padding: const EdgeInsets.all(20),
        child: productsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('خطأ: $err')),
          data: (products) {
            _initSelections(products);

            if (products.isEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    size: 56,
                    color: AppColors.neutralGrey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    L10n.t.inventoryNoSupplierProducts,
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اربط أصناف المحل بهذا المورد من شاشة تعديل الصنف',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutralGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(L10n.t.cancel),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.add_shopping_cart_rounded,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            L10n.t.inventoryOrderWhatsApp,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.supplier.name,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.neutralGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text(
                  'اختر الأصناف وحدد الكميات المطلوبة:',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final p = products[index];
                      final isSelected =
                          _selectedProductIds.contains(p.product.id);
                      final currentQtyMilli =
                          _selectedQuantities[p.product.id] ?? 1000;

                      return CheckboxListTile(
                        value: isSelected,
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.product.name,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'المتوفر: ${QuantityUtils.formatMilliUnits(p.quantityMilliUnits)} ${p.product.unitLabel}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: p.isLowStock
                                          ? AppColors.debtRed
                                          : AppColors.neutralGrey,
                                      fontWeight: p.isLowStock
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected) ...[
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline_rounded,
                                  size: 20,
                                ),
                                onPressed: currentQtyMilli > 1000
                                    ? () => setState(() {
                                          _selectedQuantities[
                                              p.product.id] =
                                              currentQtyMilli - 1000;
                                        })
                                    : null,
                              ),
                              Text(
                                '${QuantityUtils.formatMilliUnits(currentQtyMilli)} ${p.product.unitLabel}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 20,
                                ),
                                onPressed: () => setState(() {
                                  _selectedQuantities[p.product.id] =
                                      currentQtyMilli + 1000;
                                }),
                              ),
                            ],
                          ],
                        ),
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _selectedProductIds.add(p.product.id);
                            } else {
                              _selectedProductIds.remove(p.product.id);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _selectedProductIds.isEmpty
                      ? null
                      : () {
                          final message = _buildMessage(shopName, products);
                          _sendWhatsApp(message);
                        },
                  icon: const Icon(Icons.send_rounded),
                  label: const Text(
                    'إرسال الطلبية عبر واتساب',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
