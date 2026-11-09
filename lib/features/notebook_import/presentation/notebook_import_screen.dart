import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../customers/data/customer_photo_repository.dart';
import '../../customers/presentation/widgets/photo_strip.dart';
import '../data/notebook_import_service.dart';

/// One editable line on the screen.
class _Line {
  final name = TextEditingController();
  final phone = TextEditingController();
  final amount = TextEditingController();
  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final amountFocus = FocusNode();
  bool owes = true;
  final List<String> photos = [];
  Customer? existing;
  bool checking = false;

  void dispose() {
    for (final c in [name, phone, amount]) {
      c.dispose();
    }
    for (final f in [nameFocus, phoneFocus, amountFocus]) {
      f.dispose();
    }
  }
}

/// "انقل الكشكول": type customers and what they owe, line after line, as fast as possible.
/// Name → phone → amount → Enter adds the next line. Photos of the notebook page(s) are linked to
/// every customer on the page, and each line can have its own photos too (many per customer).
/// Photos stay on the phone only.
class NotebookImportScreen extends ConsumerStatefulWidget {
  const NotebookImportScreen({super.key});

  static Future<void> open(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const NotebookImportScreen()));

  @override
  ConsumerState<NotebookImportScreen> createState() => _NotebookImportScreenState();
}

class _NotebookImportScreenState extends ConsumerState<NotebookImportScreen> {
  final List<_Line> _lines = [];
  final _scroll = ScrollController();
  DateTime _asOf = DateTime.now();
  final List<String> _pagePhotos = [];
  bool _saving = false;
  int _savedPages = 0;

  @override
  void initState() {
    super.initState();
    _lines.add(_createLine());
  }

  @override
  void dispose() {
    for (final l in _lines) {
      l.dispose();
    }
    _scroll.dispose();
    super.dispose();
  }

  NotebookImportService get _service => ref.read(notebookImportServiceProvider);

  _Line _createLine() {
    final line = _Line();
    line.nameFocus.addListener(() {
      if (!line.nameFocus.hasFocus) _checkExisting(line);
    });
    line.phoneFocus.addListener(() {
      if (!line.phoneFocus.hasFocus) _checkExisting(line);
    });
    return line;
  }

  void _addLine({bool focus = true}) {
    final line = _createLine();
    setState(() => _lines.add(line));
    if (focus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        line.nameFocus.requestFocus();
        if (_scroll.hasClients) {
          _scroll.animateTo(_scroll.position.maxScrollExtent + 120,
              duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
        }
      });
    }
  }

  void _removeLine(_Line line) {
    setState(() => _lines.remove(line));
    line.dispose();
    if (_lines.isEmpty) _addLine();
  }

  Future<void> _checkExisting(_Line line) async {
    final name = line.name.text.trim();
    if (name.length < 2) {
      if (line.existing != null) setState(() => line.existing = null);
      return;
    }
    setState(() => line.checking = true);
    final match = await _service.findExisting(name, line.phone.text.trim());
    if (!mounted || !_lines.contains(line)) return;
    setState(() {
      line.existing = match;
      line.checking = false;
    });
  }

  List<RowCheck> get _checks => [
        for (final l in _lines)
          NotebookImportService.check(
            name: l.name.text,
            phone: l.phone.text,
            amount: l.amount.text,
            customerOwes: l.owes,
            hasPhotos: l.photos.isNotEmpty,
          ),
      ];

  bool get _hasUnsaved =>
      _pagePhotos.isNotEmpty ||
      _lines.any((l) => l.name.text.trim().isNotEmpty || l.amount.text.trim().isNotEmpty || l.photos.isNotEmpty);

  /// Adds photos to [target] (the page photos, or one line's photos).
  Future<void> _addPhotos(List<String> target) async {
    final paths = await pickCustomerPhotos(context, ref.read(customerPhotoRepositoryProvider));
    if (paths.isNotEmpty && mounted) setState(() => target.addAll(paths));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _asOf,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      helpText: 'الحسابات دي لحد يوم',
    );
    if (picked != null) setState(() => _asOf = picked);
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final checks = _checks;
    final firstError = checks.indexWhere((c) => c.error != null);
    if (firstError != -1) {
      _lines[firstError].nameFocus.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('سطر ${firstError + 1}: ${checks[firstError].error}'),
        backgroundColor: AppColors.debtRed,
      ));
      return;
    }
    final rows = [
      for (var i = 0; i < checks.length; i++)
        if (checks[i].row != null) checks[i].row!.withPhotos(_lines[i].photos),
    ];
    if (rows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اكتب اسم عميل واحد على الأقل')));
      return;
    }

    setState(() => _saving = true);
    try {
      final summary = await _service.saveCustomers(rows, asOf: _asOf, pagePhotos: List.of(_pagePhotos));
      if (!mounted) return;
      _savedPages++;
      final again = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('اتحفظ ✓'),
          content: Text(
            [
              if (summary.newCustomers > 0) '${summary.newCustomers} عميل جديد',
              if (summary.existingCustomers > 0) '${summary.existingCustomers} عميل موجود اتضاف على حسابه',
              'إجمالي: ${MoneyUtils.formatMoney(summary.totalPiasters)}',
            ].join('\n'),
            style: const TextStyle(height: 1.6),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('خلصت')),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('صفحة تانية')),
          ],
        ),
      );
      if (!mounted) return;
      if (again == true) {
        setState(() {
          for (final l in _lines) {
            l.dispose();
          }
          _lines.clear();
          _pagePhotos.clear();
        });
        _addLine();
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حصلت مشكلة في الحفظ، مفيش حاجة اتحفظت'), backgroundColor: AppColors.debtRed),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<bool> _confirmLeave() async {
    if (!_hasUnsaved) return true;
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تخرج من غير ما تحفظ؟'),
        content: const Text('اللي كتبته في الصفحة دي مش هيتحفظ.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('كمّل')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('اخرج')),
        ],
      ),
    );
    return leave == true;
  }

  @override
  Widget build(BuildContext context) {
    final checks = _checks;
    final valid = checks.where((c) => c.row != null).map((c) => c.row!).toList();
    final total = valid.fold<int>(0, (s, r) => s + (r.customerOwes ? r.amountPiasters : -r.amountPiasters));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmLeave() && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_savedPages == 0 ? 'انقل الكشكول 📒' : 'انقل الكشكول — صفحة ${_savedPages + 1}'),
        ),
        body: Column(
          children: [
            _Header(
              asOf: _asOf,
              pagePhotos: _pagePhotos,
              onPickDate: _pickDate,
              onAddPagePhotos: () => _addPhotos(_pagePhotos),
              onRemovePagePhoto: (i) => setState(() => _pagePhotos.removeAt(i)),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
                itemCount: _lines.length + 1,
                itemBuilder: (context, index) {
                  if (index == _lines.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: OutlinedButton.icon(
                        onPressed: _addLine,
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('سطر جديد'),
                        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                      ),
                    );
                  }
                  final line = _lines[index];
                  return _LineCard(
                    key: ObjectKey(line),
                    index: index,
                    line: line,
                    error: checks[index].error,
                    onChanged: () => setState(() {}),
                    onOwesChanged: (v) => setState(() => line.owes = v),
                    onAddPhotos: () => _addPhotos(line.photos),
                    onRemovePhoto: (i) => setState(() => line.photos.removeAt(i)),
                    onSubmitAmount: () {
                      if (index == _lines.length - 1) {
                        _addLine();
                      } else {
                        _lines[index + 1].nameFocus.requestFocus();
                      }
                    },
                    onRemove: _lines.length > 1 ? () => _removeLine(line) : null,
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${valid.length} عميل', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('إجمالي: ${MoneyUtils.formatMoney(total)}',
                          style: const TextStyle(fontSize: 13, color: AppColors.neutralGrey)),
                    ],
                  ),
                ),
                FilledButton.icon(
                  onPressed: _saving || valid.isEmpty ? null : _save,
                  icon: _saving
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.save_rounded),
                  label: Text(_saving ? 'بيحفظ…' : 'احفظ'),
                  style: FilledButton.styleFrom(minimumSize: const Size(120, 52)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final DateTime asOf;
  final List<String> pagePhotos;
  final VoidCallback onPickDate;
  final VoidCallback onAddPagePhotos;
  final ValueChanged<int> onRemovePagePhoto;

  const _Header({
    required this.asOf,
    required this.pagePhotos,
    required this.onPickDate,
    required this.onAddPagePhotos,
    required this.onRemovePagePhoto,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(asOf, DateTime.now());
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'اكتب كل عميل في سطر: الاسم، والموبايل لو موجود، والمبلغ اللي عليه. دوس "التالي" في الكيبورد عشان تنقل بسرعة.',
            style: TextStyle(fontSize: 13, color: AppColors.neutralGrey, height: 1.5),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: onPickDate,
            icon: const Icon(Icons.event_rounded, size: 20),
            label: Text(isToday ? 'الحساب لحد النهارده' : 'لحد ${DateFormat('yyyy/MM/dd').format(asOf)}',
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 8),
          Text(
            pagePhotos.isEmpty
                ? 'صور صفحة الكشكول (اختياري): بتتحفظ مع كل العملاء اللي في الصفحة'
                : '${pagePhotos.length} صورة للصفحة — هتتحفظ مع كل العملاء اللي في الصفحة',
            style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
          ),
          PhotoStrip(
            paths: pagePhotos,
            size: 56,
            addLabel: 'الصفحة',
            onAdd: onAddPagePhotos,
            onRemove: onRemovePagePhoto,
          ),
        ],
      ),
    );
  }
}

class _LineCard extends StatelessWidget {
  final int index;
  final _Line line;
  final String? error;
  final VoidCallback onChanged;
  final ValueChanged<bool> onOwesChanged;
  final VoidCallback onSubmitAmount;
  final VoidCallback? onRemove;
  final VoidCallback onAddPhotos;
  final ValueChanged<int> onRemovePhoto;

  const _LineCard({
    super.key,
    required this.index,
    required this.line,
    required this.error,
    required this.onChanged,
    required this.onOwesChanged,
    required this.onSubmitAmount,
    required this.onRemove,
    required this.onAddPhotos,
    required this.onRemovePhoto,
  });

  @override
  Widget build(BuildContext context) {
    final digitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩.,٫ +]'));
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: error != null ? AppColors.debtRed : Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 4, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 13, child: Text('${index + 1}', style: const TextStyle(fontSize: 12))),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: line.name,
                    focusNode: line.nameFocus,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(hintText: 'اسم العميل', isDense: true),
                    onChanged: (_) => onChanged(),
                    onSubmitted: (_) => line.phoneFocus.requestFocus(),
                  ),
                ),
                IconButton(
                  tooltip: 'صور للعميل ده',
                  onPressed: onAddPhotos,
                  icon: Badge(
                    isLabelVisible: line.photos.isNotEmpty,
                    label: Text('${line.photos.length}'),
                    child: const Icon(Icons.add_a_photo_outlined, size: 20),
                  ),
                ),
                if (onRemove != null)
                  IconButton(tooltip: 'شيل السطر', onPressed: onRemove, icon: const Icon(Icons.close_rounded, size: 20)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const SizedBox(width: 36),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: line.phone,
                    focusNode: line.phoneFocus,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(hintText: 'الموبايل (اختياري)', isDense: true),
                    onChanged: (_) => onChanged(),
                    onSubmitted: (_) => line.amountFocus.requestFocus(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: TextField(
                    controller: line.amount,
                    focusNode: line.amountFocus,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [digitsOnly],
                    textInputAction: TextInputAction.next,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(hintText: 'المبلغ', suffixText: 'ج', isDense: true),
                    onChanged: (_) => onChanged(),
                    onSubmitted: (_) => onSubmitAmount(),
                  ),
                ),
                const SizedBox(width: 4),
                _OwesToggle(owes: line.owes, onChanged: onOwesChanged),
              ],
            ),
            if (line.photos.isNotEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 36),
                child: PhotoStrip(paths: line.photos, size: 52, onAdd: onAddPhotos, onRemove: onRemovePhoto),
              ),
            if (error != null || line.existing != null || line.checking)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 36, top: 6),
                child: error != null
                    ? Text(error!, style: const TextStyle(color: AppColors.debtRed, fontSize: 12, fontWeight: FontWeight.w600))
                    : line.checking
                        ? const Text('بيدوّر…', style: TextStyle(fontSize: 12, color: AppColors.neutralGrey))
                        : Text(
                            'موجود عندك "${line.existing!.name}" — المبلغ هيتضاف على حسابه',
                            style: const TextStyle(fontSize: 12, color: AppColors.warningAmber, fontWeight: FontWeight.w600),
                          ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Small "عليه / له" switch. Most notebook lines are "عليه".
class _OwesToggle extends StatelessWidget {
  final bool owes;
  final ValueChanged<bool> onChanged;
  const _OwesToggle({required this.owes, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final color = owes ? AppColors.debtRed : AppColors.paymentGreen;
    return Tooltip(
      message: owes ? 'المبلغ عليه (العميل مديون)' : 'المبلغ له (انت مديون للعميل)',
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onChanged(!owes),
        child: Container(
          constraints: const BoxConstraints(minWidth: 52, minHeight: 40),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(owes ? 'عليه' : 'له', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
