import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/phone.dart';
import '../../customers/presentation/customers_providers.dart';
import '../data/installment_repository.dart';
import '../domain/installment_calculator.dart';

/// Screen for creating a new Installment Plan with live schedule preview.
class AddInstallmentPlanScreen extends ConsumerStatefulWidget {
  final String? initialCustomerId;

  const AddInstallmentPlanScreen({super.key, this.initialCustomerId});

  @override
  ConsumerState<AddInstallmentPlanScreen> createState() => _AddInstallmentPlanScreenState();
}

class _AddInstallmentPlanScreenState extends ConsumerState<AddInstallmentPlanScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCustomerId;
  final _itemController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _downPaymentController = TextEditingController(text: '0');
  final _countController = TextEditingController(text: '12');
  final _guarantorNameController = TextEditingController();
  final _guarantorPhoneController = TextEditingController();
  final _notesController = TextEditingController();

  InstallmentFrequency _frequency = InstallmentFrequency.monthly;
  DateTime _startDate = InstallmentCalculator.addMonths(DateTime.now(), 1);
  String? _capturedPhotoPath;
  bool _linkToLedger = true;
  bool _isSaving = false;

  final List<String> _itemSuggestions = [
    'موبايل',
    'شاشة تلفزيون',
    'غسالة',
    'ثلاجة',
    'بوتاجاز',
    'لابتوب',
    'موتوسيكل',
    'أثاث / مفروشات',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCustomerId = widget.initialCustomerId;
  }

  @override
  void dispose() {
    _itemController.dispose();
    _totalPriceController.dispose();
    _downPaymentController.dispose();
    _countController.dispose();
    _guarantorNameController.dispose();
    _guarantorPhoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  int get _totalPricePiasters {
    final egp = double.tryParse(_totalPriceController.text.trim()) ?? 0.0;
    return (egp * 100).round();
  }

  int get _downPaymentPiasters {
    final egp = double.tryParse(_downPaymentController.text.trim()) ?? 0.0;
    return (egp * 100).round();
  }

  int get _installmentCount {
    return int.tryParse(_countController.text.trim()) ?? 0;
  }

  List<GeneratedInstallment> get _previewSchedule {
    if (_totalPricePiasters <= 0 || _installmentCount <= 0 || _downPaymentPiasters >= _totalPricePiasters) {
      return [];
    }
    try {
      return InstallmentCalculator.generateSchedule(
        totalPricePiasters: _totalPricePiasters,
        downPaymentPiasters: _downPaymentPiasters,
        count: _installmentCount,
        frequency: _frequency.name,
        startDate: _startDate,
      );
    } catch (_) {
      return [];
    }
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (image != null) {
      setState(() => _capturedPhotoPath = image.path);
    }
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _savePlan() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCustomerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('برجاء اختيار العميل أولاً')),
      );
      return;
    }

    if (_downPaymentPiasters >= _totalPricePiasters) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('المقدم يجب أن يكون أقل من إجمالي السعر')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final repo = ref.read(installmentRepositoryProvider);

      String? persistedPhoto;
      if (_capturedPhotoPath != null) {
        persistedPhoto = await repo.persistPhoto(_capturedPhotoPath!);
      }

      await repo.createPlan(
        customerId: _selectedCustomerId!,
        itemDescription: _itemController.text.trim(),
        totalPricePiasters: _totalPricePiasters,
        downPaymentPiasters: _downPaymentPiasters,
        installmentCount: _installmentCount,
        frequency: _frequency,
        startDate: _startDate,
        guarantorName: _guarantorNameController.text.trim(),
        guarantorPhone: _guarantorPhoneController.text.trim(),
        notes: _notesController.text.trim(),
        photoPath: persistedPhoto,
        linkToCustomerLedger: _linkToLedger,
      );

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إنشاء خطة القسط وجدولة الأقساط بنجاح ✓'),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: AppColors.debtRed),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customersAsync = ref.watch(customersListStreamProvider);
    final dateFmt = DateFormat('yyyy/MM/dd');
    final schedule = _previewSchedule;

    return Scaffold(
      appBar: AppBar(
        title: const Text('خطة قسط جديدة', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 1. Customer Selection
            Text('العميل', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            customersAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('خطأ في تحميل العملاء: $e'),
              data: (customers) {
                return DropdownButtonFormField<String>(
                  initialValue: _selectedCustomerId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'اختر العميل',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  items: customers.map((c) {
                    return DropdownMenuItem<String>(
                      value: c.customer.id,
                      child: Text(
                        '${c.customer.name}${c.customer.phone != null ? ' (${c.customer.phone})' : ''}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedCustomerId = val),
                  validator: (val) => val == null ? 'برجاء اختيار العميل' : null,
                );
              },
            ),
            const SizedBox(height: 20),

            // 2. Merchandise / Item Details
            Text('بيانات السلعة والمبالغ', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            TextFormField(
              controller: _itemController,
              decoration: const InputDecoration(
                labelText: 'اسم السلعة أو المنتج *',
                hintText: 'مثلاً: سامسونج A15 128GB',
                prefixIcon: Icon(Icons.shopping_bag_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (val) => (val == null || val.trim().length < 2) ? 'اسم السلعة يجب ألا يقل عن حرفين' : null,
            ),
            const SizedBox(height: 8),

            // Quick Suggestions Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _itemSuggestions.map((s) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: ActionChip(
                      label: Text(s, style: const TextStyle(fontSize: 12)),
                      onPressed: () {
                        setState(() {
                          _itemController.text = s;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Total Price & Down Payment
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _totalPriceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'السعر الإجمالي (جنيه) *',
                      hintText: 'مثلاً: 12000',
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      final numVal = double.tryParse(val ?? '');
                      if (numVal == null || numVal <= 0) return 'مبلغ غير صحيح';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _downPaymentController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'المقدم (جنيه)',
                      hintText: '0',
                      prefixIcon: Icon(Icons.paid_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Net Principal calculation preview banner
            if (_totalPricePiasters > 0)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Expanded(child: Text('المبلغ المتبقي للتقسيط:')),
                    const SizedBox(width: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        MoneyUtils.formatMoney(_totalPricePiasters - _downPaymentPiasters),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryGreen),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // 3. Installment Duration & Frequency
            Text('المدة ودورية السداد', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Number of installments quick chips
            Wrap(
              spacing: 8,
              children: [3, 6, 10, 12, 18, 24].map((count) {
                final isSelected = _countController.text == count.toString();
                return ChoiceChip(
                  label: Text('$count قسط'),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _countController.text = count.toString());
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _countController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'عدد الأقساط *',
                      prefixIcon: Icon(Icons.format_list_numbered_rounded),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      final n = int.tryParse(val ?? '');
                      if (n == null || n <= 0) return 'أدخل عدداً صحيحاً';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<InstallmentFrequency>(
                    initialValue: _frequency,
                    decoration: const InputDecoration(
                      labelText: 'الدورية',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: InstallmentFrequency.monthly, child: Text('شهري')),
                      DropdownMenuItem(value: InstallmentFrequency.weekly, child: Text('أسبوعي')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _frequency = val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // First due date picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_rounded, color: AppColors.primaryGreen),
              title: const Text('تاريخ استحقاق أول قسط'),
              subtitle: Text(dateFmt.format(_startDate)),
              trailing: OutlinedButton(
                onPressed: _selectStartDate,
                child: const Text('تغيير التاريخ'),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Guarantor & Security Details
            Text('الضامن والمستندات (اختياري)', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            TextFormField(
              controller: _guarantorNameController,
              decoration: const InputDecoration(
                labelText: 'اسم الضامن',
                hintText: 'مثلاً: محمد السيد إبراهيم',
                prefixIcon: Icon(Icons.shield_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _guarantorPhoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'رقم موبايل الضامن',
                hintText: '010xxxxxxxx',
                prefixIcon: Icon(Icons.phone_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                if (val != null && val.trim().isNotEmpty && PhoneUtils.normalizeEgyptianMobile(val) == null) {
                  return 'رقم الموبايل غير صحيح (010, 011, 012, 015)';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Contract / ID Photo
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(_capturedPhotoPath != null ? 'تم التقاط صورة المستند ✓' : 'تصوير العقد / إيصال الأمانة / البطاقة'),
              subtitle: Text(_capturedPhotoPath != null ? 'اضغط لتغيير الصورة' : 'حفظ صورة العقد للرجوع إليها في أي وقت'),
              trailing: ElevatedButton.icon(
                icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                label: const Text('تصوير'),
                onPressed: _pickPhoto,
              ),
            ),
            const SizedBox(height: 8),

            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'ملاحظات إضافية',
                prefixIcon: Icon(Icons.notes_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Link to Ledger Checkbox
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('ربط بكشكول العميل تلقائياً'),
              subtitle: const Text('تسجيل السعر الإجمالي كدين والمقدم كدفعة في حساب العميل العام'),
              value: _linkToLedger,
              onChanged: (val) => setState(() => _linkToLedger = val ?? true),
            ),
            const SizedBox(height: 24),

            // 5. Live Schedule Preview Table
            if (schedule.isNotEmpty) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'معاينة جدول الأقساط (${schedule.length} أقساط)',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'قيمة القسط: ~${MoneyUtils.formatMoney(schedule.first.amountPiasters)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: schedule.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (ctx, index) {
                    final item = schedule[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text('${item.index}', style: TextStyle(fontSize: 12, color: theme.colorScheme.primary)),
                      ),
                      title: Text(dateFmt.format(item.dueDate)),
                      trailing: Text(
                        MoneyUtils.formatMoney(item.amountPiasters),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _isSaving ? null : _savePlan,
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('حفظ خطة القسط والجدولة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
