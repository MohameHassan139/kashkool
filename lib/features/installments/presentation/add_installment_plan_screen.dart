import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/phone.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../../customers/presentation/customers_providers.dart';
import '../data/installment_repository.dart';
import '../domain/installment_calculator.dart';
import '../../../l10n/l10n.dart';

/// Screen for creating a new Installment Plan with live schedule preview.
class AddInstallmentPlanScreen extends ConsumerStatefulWidget {
  final String? initialCustomerId;

  const AddInstallmentPlanScreen({super.key, this.initialCustomerId});

  @override
  ConsumerState<AddInstallmentPlanScreen> createState() =>
      _AddInstallmentPlanScreenState();
}

class _AddInstallmentPlanScreenState
    extends ConsumerState<AddInstallmentPlanScreen> {
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
    L10n.t.addInstallmentPlanScreen1,
    L10n.t.addInstallmentPlanScreen2,
    L10n.t.addInstallmentPlanScreen3,
    L10n.t.addInstallmentPlanScreen4,
    L10n.t.addInstallmentPlanScreen5,
    L10n.t.addInstallmentPlanScreen6,
    L10n.t.addInstallmentPlanScreen7,
    L10n.t.addInstallmentPlanScreen8,
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
    if (_totalPricePiasters <= 0 ||
        _installmentCount <= 0 ||
        _downPaymentPiasters >= _totalPricePiasters) {
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
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
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
      AppGlassToast.showInfo(context, L10n.t.addInstallmentPlanScreen9);
      return;
    }

    if (_downPaymentPiasters >= _totalPricePiasters) {
      AppGlassToast.showError(context, L10n.t.addInstallmentPlanScreen10);
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
        AppGlassToast.showSuccess(context, L10n.t.addInstallmentPlanScreen11);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        AppGlassToast.showError(context, L10n.t.addInstallmentPlanScreen12(e));
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
        title: Text(
          L10n.t.installmentsScreen14,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 1. Customer Selection
            Text(
              L10n.t.oldInstallmentImportScreen13,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            customersAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text(L10n.t.addInstallmentPlanScreen13(e)),
              data: (customers) {
                return DropdownButtonFormField<String>(
                  initialValue: _selectedCustomerId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: L10n.t.addInstallmentPlanScreen14,
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
                  validator: (val) =>
                      val == null ? L10n.t.addInstallmentPlanScreen15 : null,
                );
              },
            ),
            const SizedBox(height: 20),

            // 2. Merchandise / Item Details
            Text(
              L10n.t.addInstallmentPlanScreen16,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            TextFormField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: L10n.t.addInstallmentPlanScreen17,
                hintText: L10n.t.addInstallmentPlanScreen18,
                prefixIcon: Icon(Icons.shopping_bag_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (val) => (val == null || val.trim().length < 2)
                  ? L10n.t.addInstallmentPlanScreen19
                  : null,
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
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: L10n.t.addInstallmentPlanScreen20,
                      hintText: L10n.t.addInstallmentPlanScreen21,
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      final numVal = double.tryParse(val ?? '');
                      if (numVal == null || numVal <= 0)
                        return L10n.t.addInstallmentPlanScreen22;
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _downPaymentController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: L10n.t.addInstallmentPlanScreen23,
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
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(L10n.t.addInstallmentPlanScreen24)),
                    const SizedBox(width: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        MoneyUtils.formatMoney(
                          _totalPricePiasters - _downPaymentPiasters,
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // 3. Installment Duration & Frequency
            Text(
              L10n.t.addInstallmentPlanScreen25,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Number of installments quick chips
            Wrap(
              spacing: 8,
              children: [3, 6, 10, 12, 18, 24].map((count) {
                final isSelected = _countController.text == count.toString();
                return ChoiceChip(
                  label: Text(L10n.t.addInstallmentPlanScreen26(count)),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val)
                      setState(() => _countController.text = count.toString());
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
                    decoration: InputDecoration(
                      labelText: L10n.t.addInstallmentPlanScreen27,
                      prefixIcon: Icon(Icons.format_list_numbered_rounded),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) {
                      final n = int.tryParse(val ?? '');
                      if (n == null || n <= 0)
                        return L10n.t.addInstallmentPlanScreen28;
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<InstallmentFrequency>(
                    initialValue: _frequency,
                    decoration: InputDecoration(
                      labelText: L10n.t.addInstallmentPlanScreen29,
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: InstallmentFrequency.monthly,
                        child: Text(L10n.t.oldInstallmentImportScreen32),
                      ),
                      DropdownMenuItem(
                        value: InstallmentFrequency.weekly,
                        child: Text(L10n.t.oldInstallmentImportScreen33),
                      ),
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
              leading: const Icon(
                Icons.event_rounded,
                color: AppColors.primaryGreen,
              ),
              title: Text(L10n.t.addInstallmentPlanScreen30),
              subtitle: Text(dateFmt.format(_startDate)),
              trailing: OutlinedButton(
                onPressed: _selectStartDate,
                child: Text(L10n.t.addInstallmentPlanScreen31),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Guarantor & Security Details
            Text(
              L10n.t.addInstallmentPlanScreen32,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            TextFormField(
              controller: _guarantorNameController,
              decoration: InputDecoration(
                labelText: L10n.t.oldInstallmentImportScreen35,
                hintText: L10n.t.addInstallmentPlanScreen33,
                prefixIcon: Icon(Icons.shield_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _guarantorPhoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: L10n.t.addInstallmentPlanScreen34,
                hintText: '010xxxxxxxx',
                prefixIcon: Icon(Icons.phone_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                if (val != null &&
                    val.trim().isNotEmpty &&
                    !PhoneUtils.isValidPhone(val)) {
                  return L10n.t.addInstallmentPlanScreen35;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Contract / ID Photo
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(
                _capturedPhotoPath != null
                    ? L10n.t.addInstallmentPlanScreen36
                    : L10n.t.addInstallmentPlanScreen37,
              ),
              subtitle: Text(
                _capturedPhotoPath != null
                    ? L10n.t.addInstallmentPlanScreen38
                    : L10n.t.addInstallmentPlanScreen39,
              ),
              trailing: ElevatedButton.icon(
                icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                label: Text(L10n.t.addInstallmentPlanScreen40),
                onPressed: _pickPhoto,
              ),
            ),
            const SizedBox(height: 8),

            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: L10n.t.addInstallmentPlanScreen41,
                prefixIcon: Icon(Icons.notes_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Link to Ledger Checkbox
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(L10n.t.addInstallmentPlanScreen42),
              subtitle: Text(L10n.t.addInstallmentPlanScreen43),
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
                      L10n.t.addInstallmentPlanScreen44(schedule.length),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      L10n.t.addInstallmentPlanScreen45(
                        MoneyUtils.formatMoney(schedule.first.amountPiasters),
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
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
                        child: Text(
                          '${item.index}',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.primary,
                          ),
                        ),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _isSaving ? null : _savePlan,
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      L10n.t.addInstallmentPlanScreen46,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
