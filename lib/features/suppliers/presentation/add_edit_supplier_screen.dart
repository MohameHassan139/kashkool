import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/phone.dart';
import '../../../l10n/app_localizations.dart';
import '../data/supplier_repository.dart';
import '../domain/supplier_with_balance.dart';

/// Screen to add a new supplier or edit an existing supplier's details.
class AddEditSupplierScreen extends ConsumerStatefulWidget {
  final Supplier? supplier;

  const AddEditSupplierScreen({super.key, this.supplier});

  bool get isEditing => supplier != null;

  @override
  ConsumerState<AddEditSupplierScreen> createState() => _AddEditSupplierScreenState();
}

class _AddEditSupplierScreenState extends ConsumerState<AddEditSupplierScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _companyController;
  late final TextEditingController _phoneController;
  late final TextEditingController _notesController;
  int? _selectedVisitDay;
  Supplier? _duplicateSupplier;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final s = widget.supplier;
    _nameController = TextEditingController(text: s?.name ?? '');
    _companyController = TextEditingController(text: s?.company ?? '');
    _phoneController = TextEditingController(text: s?.phone ?? '');
    _notesController = TextEditingController(text: s?.notes ?? '');
    _selectedVisitDay = s?.visitDay;

    _nameController.addListener(_checkDuplicate);
    _phoneController.addListener(_checkDuplicate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _checkDuplicate() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.length < 2 && phone.isEmpty) {
      if (_duplicateSupplier != null) {
        setState(() => _duplicateSupplier = null);
      }
      return;
    }

    final repo = ref.read(supplierRepositoryProvider);
    final dup = await repo.checkForDuplicates(
      name: name,
      phone: phone.isNotEmpty ? phone : null,
      excludeSupplierId: widget.supplier?.id,
    );

    if (mounted) {
      setState(() => _duplicateSupplier = dup);
    }
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final company = _companyController.text.trim();
    final phone = _phoneController.text.trim();
    final notes = _notesController.text.trim();

    setState(() => _isSaving = true);
    final repo = ref.read(supplierRepositoryProvider);

    try {
      if (widget.isEditing) {
        await repo.updateSupplier(
          id: widget.supplier!.id,
          name: name,
          company: company.isNotEmpty ? company : null,
          phone: phone.isNotEmpty ? phone : null,
          visitDay: _selectedVisitDay,
          notes: notes.isNotEmpty ? notes : null,
        );
      } else {
        await repo.addSupplier(
          name: name,
          company: company.isNotEmpty ? company : null,
          phone: phone.isNotEmpty ? phone : null,
          visitDay: _selectedVisitDay,
          notes: notes.isNotEmpty ? notes : null,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.supplierSaved),
            backgroundColor: AppColors.paymentGreen,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: AppColors.debtRed),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? l10n.editSupplier : l10n.addNewSupplier),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Duplicate warning alert if detected
                if (_duplicateSupplier != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.warningAmberLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.warningAmber),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: AppColors.warningAmber),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${l10n.duplicateCustomerWarning} (${_duplicateSupplier!.name})',
                            style: const TextStyle(
                              color: Color(0xFF92400E),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Supplier / Rep Name
                TextFormField(
                  controller: _nameController,
                  autofocus: !widget.isEditing,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.supplierName,
                    hintText: l10n.supplierNameHint,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                  ),
                  validator: (val) {
                    final text = val?.trim() ?? '';
                    if (text.isEmpty) return l10n.supplierNameRequired;
                    if (text.length < 2) return l10n.customerNameTooShort;
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Company Name
                TextFormField(
                  controller: _companyController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.company,
                    hintText: l10n.companyHint,
                    prefixIcon: const Icon(Icons.business_rounded),
                  ),
                ),
                const SizedBox(height: 16),

                // Mobile Phone
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.customerPhone,
                    hintText: l10n.customerPhoneHint,
                    prefixIcon: const Icon(Icons.phone_outlined),
                  ),
                  validator: (val) {
                    final text = val?.trim() ?? '';
                    if (text.isEmpty) return null;
                    if (!PhoneUtils.isValidEgyptianMobile(text)) {
                      return l10n.customerPhoneInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Weekly Visit Day Dropdown
                DropdownButtonFormField<int?>(
                  initialValue: _selectedVisitDay,
                  decoration: InputDecoration(
                    labelText: l10n.visitDay,
                    prefixIcon: const Icon(Icons.calendar_today_rounded),
                  ),
                  items: [
                    DropdownMenuItem<int?>(
                      value: null,
                      child: Text(l10n.noSpecificDay),
                    ),
                    for (int i = 0; i < 7; i++)
                      DropdownMenuItem<int?>(
                        value: i,
                        child: Text(SupplierWithBalance.getWeekdayName(i)!),
                      ),
                  ],
                  onChanged: (val) {
                    setState(() => _selectedVisitDay = val);
                  },
                ),
                const SizedBox(height: 16),

                // Notes
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: l10n.supplierNotes,
                    hintText: l10n.supplierNotesHint,
                    prefixIcon: const Icon(Icons.note_alt_outlined),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 32),

                // Save Button (min 56dp height)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text(
                          l10n.save,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
