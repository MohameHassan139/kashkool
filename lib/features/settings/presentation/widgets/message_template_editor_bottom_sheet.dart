import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/whatsapp_template.dart';
import '../../data/settings_repository.dart';

/// Interactive modal sheet to edit WhatsApp / SMS reminder template with chips and live preview.
class MessageTemplateEditorBottomSheet extends ConsumerStatefulWidget {
  const MessageTemplateEditorBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const MessageTemplateEditorBottomSheet(),
    );
  }

  @override
  ConsumerState<MessageTemplateEditorBottomSheet> createState() =>
      _MessageTemplateEditorBottomSheetState();
}

class _MessageTemplateEditorBottomSheetState
    extends ConsumerState<MessageTemplateEditorBottomSheet> {
  final _templateController = TextEditingController();
  bool _isLoading = true;
  String _shopName = 'بقالة الأمانة';
  String _paymentInfo = 'فودافون كاش: 01012345678';
  String? _shopCode;

  @override
  void initState() {
    super.initState();
    _loadCurrentTemplate();
  }

  Future<void> _loadCurrentTemplate() async {
    final repo = ref.read(settingsRepositoryProvider);
    final template = await repo.getMessageTemplate();
    final name = await repo.getShopName();
    final pay = await repo.getPaymentInfo();
    final code = await repo.getOrCreateShopCode();

    if (mounted) {
      setState(() {
        _templateController.text = template;
        _shopName = name.isNotEmpty ? name : 'بقالة الأمانة';
        _paymentInfo = pay.isNotEmpty ? pay : 'فودافون كاش: 01012345678';
        _shopCode = code;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _templateController.dispose();
    super.dispose();
  }

  void _insertPlaceholder(String placeholder) {
    final text = _templateController.text;
    final selection = _templateController.selection;
    final start = selection.start >= 0 ? selection.start : text.length;
    final end = selection.end >= 0 ? selection.end : text.length;

    final newText = text.replaceRange(start, end, placeholder);
    _templateController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: start + placeholder.length),
    );
    setState(() {});
  }

  void _applyPreset(String preset) {
    setState(() {
      _templateController.text = preset;
    });
  }

  String _renderPreview() {
    return WhatsAppTemplateUtils.render(
      template: _templateController.text,
      customerName: 'محمد أحمد',
      shopName: _shopName,
      balancePiasters: 25000, // 250.00 EGP
      paymentInfo: _paymentInfo,
      includeGrowthFooter: true,
      shopCode: _shopCode,
    );
  }

  Future<void> _save() async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.setMessageTemplate(_templateController.text.trim());
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ نموذج الرسالة بنجاح 👍'),
          backgroundColor: AppColors.paymentGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 48,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Text(
              'تعديل رسالة التذكير 💬',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Presets row
            Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('نماذج جاهزة: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ActionChip(
                  label: const Text('ودّي 😊'),
                  backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                  onPressed: () => _applyPreset(WhatsAppTemplateUtils.defaultFriendlyTemplate),
                ),
                ActionChip(
                  label: const Text('رسمي 👔'),
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  onPressed: () => _applyPreset(WhatsAppTemplateUtils.defaultFormalTemplate),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Placeholder chips
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _buildPlaceholderChip('{customer_name}', 'اسم العميل'),
                _buildPlaceholderChip('{balance}', 'المبلغ'),
                _buildPlaceholderChip('{shop_name}', 'اسم المحل'),
                _buildPlaceholderChip('{payment_info}', 'بيانات الدفع'),
                _buildPlaceholderChip('{last_transaction_date}', 'تاريخ آخر حركة'),
              ],
            ),
            const SizedBox(height: 12),

            // Text input
            TextField(
              controller: _templateController,
              maxLines: 5,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'اكتب نص رسالة التذكير هنا...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Live Preview Card
            Text(
              'معاينة الرسالة كما ستصل للعميل:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF005C4B) : const Color(0xFFDCF8C6), // WhatsApp soft green
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? const Color(0xFF0B8067) : const Color(0xFFC7EBB0),
                ),
              ),
              child: Text(
                _renderPreview(),
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white : Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'حفظ النموذج',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderChip(String placeholder, String label) {
    return ActionChip(
      avatar: Icon(Icons.add, size: 16, color: Theme.of(context).colorScheme.primary),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      onPressed: () => _insertPlaceholder(placeholder),
    );
  }
}
