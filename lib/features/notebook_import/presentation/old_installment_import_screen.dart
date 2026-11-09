import 'package:drift/drift.dart' hide Column, Table;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/arabic_search.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/phone.dart';
import '../../customers/data/customer_photo_repository.dart';
import '../../customers/data/customer_repository.dart';
import '../../customers/presentation/widgets/photo_strip.dart';
import '../data/notebook_import_service.dart';

/// "قسط قديم": an installment plan that started before the app.
/// The owner types the total price, what was already paid, how many installments are left,
/// and when the next one is due. The app builds the remaining schedule.
class OldInstallmentImportScreen extends ConsumerStatefulWidget {
  const OldInstallmentImportScreen({super.key});

  static Future<void> open(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const OldInstallmentImportScreen()));

  @override
  ConsumerState<OldInstallmentImportScreen> createState() => _OldInstallmentImportScreenState();
}

class _OldInstallmentImportScreenState extends ConsumerState<OldInstallmentImportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerName = TextEditingController();
  final _phone = TextEditingController();
  final _item = TextEditingController();
  final _total = TextEditingController();
  final _paid = TextEditingController();
  final _count = TextEditingController();
  final _guarantorName = TextEditingController();
  final _guarantorPhone = TextEditingController();

  List<Customer> _customers = const [];
  Customer? _selected;
  DateTime _nextDue = DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
  InstallmentFrequency _frequency = InstallmentFrequency.monthly;
  final List<String> _photos = [];
  bool _showGuarantor = false;
  bool _saving = false;
  int _savedCount = 0;

  /// Changes after each save so the customer field starts empty again.
  int _formGeneration = 0;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  @override
  void dispose() {
    for (final c in [_customerName, _phone, _item, _total, _paid, _count, _guarantorName, _guarantorPhone]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _loadCustomers() async {
    final db = ref.read(databaseProvider);
    final list = await (db.select(db.customers)
          ..where((c) => c.deletedAt.isNull())
          ..orderBy([(c) => OrderingTerm.asc(c.name)]))
        .get();
    if (mounted) setState(() => _customers = list);
  }

  int get _totalPiasters => MoneyUtils.toPiasters(_total.text, fallback: 0);
  int get _paidPiasters => MoneyUtils.toPiasters(_paid.text, fallback: 0);
  int get _countValue => int.tryParse(MoneyUtils.normalizeNumberString(_count.text)) ?? 0;
  int get _remaining => _totalPiasters - _paidPiasters;

  Future<void> _addPhotos() async {
    final paths = await pickCustomerPhotos(context, ref.read(customerPhotoRepositoryProvider));
    if (paths.isNotEmpty && mounted) setState(() => _photos.addAll(paths));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _nextDue,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'ميعاد القسط الجاي',
    );
    if (picked != null) setState(() => _nextDue = picked);
  }

  String? _required(String? v, String message) => (v == null || v.trim().isEmpty) ? message : null;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      var customerId = _selected?.id;
      if (customerId == null) {
        final repo = ref.read(customerRepositoryProvider);
        final existing = await repo.checkForDuplicates(name: _customerName.text, phone: _phone.text);
        customerId = existing?.id ??
            await repo.addCustomer(name: _customerName.text, phone: _phone.text.trim().isEmpty ? null : _phone.text);
      }
      await ref.read(notebookImportServiceProvider).saveOldInstallment(
            customerId: customerId,
            itemDescription: _item.text.trim(),
            totalPricePiasters: _totalPiasters,
            paidPiasters: _paidPiasters,
            remainingCount: _countValue,
            nextDueDate: _nextDue,
            frequency: _frequency,
            guarantorName: _guarantorName.text.trim().isEmpty ? null : _guarantorName.text.trim(),
            guarantorPhone: _guarantorPhone.text.trim().isEmpty ? null : _guarantorPhone.text.trim(),
            photoPaths: List.of(_photos),
          );
      if (!mounted) return;
      _savedCount++;
      final again = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('اتحفظ القسط ✓'),
          content: Text(
            'فاضل ${MoneyUtils.formatMoney(_remaining)} على $_countValue قسط، أولهم يوم ${DateFormat('yyyy/MM/dd').format(_nextDue)}.',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('خلصت')),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('قسط تاني')),
          ],
        ),
      );
      if (!mounted) return;
      if (again == true) {
        _formKey.currentState!.reset();
        for (final c in [_customerName, _phone, _item, _total, _paid, _count, _guarantorName, _guarantorPhone]) {
          c.clear();
        }
        setState(() {
          _selected = null;
          _photos.clear();
          _showGuarantor = false;
          _formGeneration++;
        });
        await _loadCustomers();
      } else {
        Navigator.of(context).pop();
      }
    } on ArgumentError catch (e) {
      _snack('${e.message}');
    } catch (_) {
      _snack('حصلت مشكلة في الحفظ، مفيش حاجة اتحفظت');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: AppColors.debtRed));
  }

  @override
  Widget build(BuildContext context) {
    final money = FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩.,٫]'));
    final remaining = _remaining;
    final count = _countValue;
    final preview = (_totalPiasters > 0 && remaining > 0 && count > 0)
        ? 'فاضل ${MoneyUtils.formatMoney(remaining)} — $count قسط × حوالي '
            '${MoneyUtils.formatMoney(NotebookImportService.perInstallment(remaining, count))}'
            '${_frequency == InstallmentFrequency.monthly ? ' شهرياً' : ' أسبوعياً'}'
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(_savedCount == 0 ? 'قسط قديم من الكشكول' : 'قسط قديم (${_savedCount + 1})')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
          children: [
            const Text(
              'للأقساط اللي بدأت قبل التطبيق: اكتب السعر، واللي اتدفع لحد دلوقتي، وعدد الأقساط الباقية. '
              'التطبيق هيعمل جدول الباقي بس، ومش هيحسب المدفوع قبل كده في درج النهارده.',
              style: TextStyle(fontSize: 13, color: AppColors.neutralGrey, height: 1.5),
            ),
            const SizedBox(height: 16),
            _section('العميل'),
            Autocomplete<Customer>(
              key: ValueKey(_formGeneration),
              displayStringForOption: (c) => c.name,
              optionsBuilder: (value) {
                final q = value.text.trim();
                if (q.isEmpty) return const Iterable<Customer>.empty();
                return _customers.where((c) => ArabicSearchUtils.matches(c.name, q) || (c.phone ?? '').contains(q)).take(8);
              },
              onSelected: (c) => setState(() {
                _selected = c;
                _customerName.text = c.name;
              }),
              fieldViewBuilder: (context, controller, focusNode, onSubmit) {
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'اسم العميل',
                    hintText: 'اكتب اسم عميل موجود أو جديد',
                    suffixIcon: _selected != null ? const Icon(Icons.check_circle_rounded, color: AppColors.paymentGreen) : null,
                  ),
                  onChanged: (v) {
                    _customerName.text = v;
                    if (_selected != null && v != _selected!.name) setState(() => _selected = null);
                  },
                  validator: (v) => (v == null || v.trim().length < 2) ? 'اكتب اسم العميل' : null,
                );
              },
              optionsViewBuilder: (context, onSelected, options) => Align(
                alignment: AlignmentDirectional.topStart,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 260, maxWidth: 420),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        for (final c in options)
                          ListTile(
                            title: Text(c.name),
                            subtitle: c.phone == null ? null : Text(PhoneUtils.formatDisplay(c.phone)),
                            onTap: () => onSelected(c),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_selected == null) ...[
              const SizedBox(height: 10),
              TextFormField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(labelText: 'موبايل العميل (لو جديد — اختياري)'),
                validator: (v) => (v != null && v.trim().isNotEmpty && !PhoneUtils.isValidEgyptianMobile(v)) ? 'رقم الموبايل غلط' : null,
              ),
            ],
            const SizedBox(height: 20),
            _section('القسط'),
            TextFormField(
              controller: _item,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'السلعة', hintText: 'مثلاً: تلاجة توشيبا'),
              validator: (v) => (v == null || v.trim().length < 2) ? 'اكتب اسم السلعة' : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _total,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [money],
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(labelText: 'السعر الإجمالي', suffixText: 'ج'),
                    onChanged: (_) => setState(() {}),
                    validator: (v) => _required(v, 'مطلوب') ?? (_totalPiasters <= 0 ? 'غلط' : null),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _paid,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [money],
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(labelText: 'اتدفع لحد دلوقتي', suffixText: 'ج'),
                    onChanged: (_) => setState(() {}),
                    validator: (_) => _remaining <= 0 ? 'لازم يكون أقل من السعر' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _count,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩]'))],
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(labelText: 'عدد الأقساط الباقية'),
                    onChanged: (_) => setState(() {}),
                    validator: (_) => (_countValue < 1 || _countValue > 120) ? 'من 1 لـ 120' : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    icon: const Icon(Icons.event_rounded),
                    label: Text('الجاي: ${DateFormat('yyyy/MM/dd').format(_nextDue)}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SegmentedButton<InstallmentFrequency>(
              segments: const [
                ButtonSegment(value: InstallmentFrequency.monthly, label: Text('شهري')),
                ButtonSegment(value: InstallmentFrequency.weekly, label: Text('أسبوعي')),
              ],
              selected: {_frequency},
              onSelectionChanged: (s) => setState(() => _frequency = s.first),
            ),
            if (preview != null)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(preview, style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => setState(() => _showGuarantor = !_showGuarantor),
              icon: Icon(_showGuarantor ? Icons.expand_less_rounded : Icons.expand_more_rounded),
              label: const Text('الضامن (اختياري)'),
            ),
            if (_showGuarantor) ...[
              TextFormField(controller: _guarantorName, decoration: const InputDecoration(labelText: 'اسم الضامن')),
              const SizedBox(height: 10),
              TextFormField(
                controller: _guarantorPhone,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(labelText: 'موبايل الضامن'),
              ),
            ],
            const SizedBox(height: 12),
            _section('صور من الكشكول أو العقد (اختياري — بتفضل على الموبايل)'),
            Text(
              _photos.isEmpty
                  ? 'تقدر تضيف كذا صورة: صفحات الكشكول، العقد، بطاقة الضامن…'
                  : '${_photos.length} صورة — هتتحفظ في صور العميل',
              style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
            ),
            PhotoStrip(paths: _photos, size: 72, onAdd: _addPhotos, onRemove: (i) => setState(() => _photos.removeAt(i))),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton.icon(
            onPressed: _saving ? null : _save,
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            icon: _saving
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.save_rounded),
            label: Text(_saving ? 'بيحفظ…' : 'احفظ القسط'),
          ),
        ),
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.primaryBlue)),
      );
}
