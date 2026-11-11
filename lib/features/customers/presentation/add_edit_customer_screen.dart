import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/phone.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../../settings/data/settings_repository.dart';
import '../data/customer_repository.dart';

/// Screen for adding a new customer or editing an existing one.
class AddEditCustomerScreen extends ConsumerStatefulWidget {
  final Customer? customer;

  const AddEditCustomerScreen({super.key, this.customer});

  @override
  ConsumerState<AddEditCustomerScreen> createState() => _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends ConsumerState<AddEditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _creditLimitController;
  late final TextEditingController _notesController;

  bool _isSaving = false;
  Customer? _duplicateCustomer;

  bool get _isEditing => widget.customer != null;

  @override
  void initState() {
    super.initState();
    final c = widget.customer;
    _nameController = TextEditingController(text: c?.name ?? '');
    _phoneController = TextEditingController(text: c?.phone ?? '');
    _notesController = TextEditingController(text: c?.notes ?? '');

    final limitPiasters = c?.creditLimitPiasters;
    _creditLimitController = TextEditingController(
      text: limitPiasters != null ? (limitPiasters / MoneyUtils.piastersPerPound).toStringAsFixed(0) : '',
    );

    _nameController.addListener(_checkDuplicate);
    _phoneController.addListener(_checkDuplicate);

    if (!_isEditing) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final defaultLimit = await ref.read(settingsRepositoryProvider).getDefaultCreditLimitPiasters();
        if (defaultLimit != null && _creditLimitController.text.isEmpty && mounted) {
          setState(() {
            _creditLimitController.text = (defaultLimit / MoneyUtils.piastersPerPound).toStringAsFixed(0);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _creditLimitController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _checkDuplicate() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.length < 2 && phone.isEmpty) {
      if (_duplicateCustomer != null) {
        setState(() => _duplicateCustomer = null);
      }
      return;
    }

    final repo = ref.read(customerRepositoryProvider);
    final dup = await repo.checkForDuplicates(
      name: name,
      phone: phone.isNotEmpty ? phone : null,
      excludeCustomerId: widget.customer?.id,
    );

    if (mounted) {
      setState(() => _duplicateCustomer = dup);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final repo = ref.read(customerRepositoryProvider);
    final l10n = AppLocalizations.of(context)!;

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim();
    final notes = _notesController.text.trim().isEmpty ? null : _notesController.text.trim();

    int? creditLimitPiasters;
    if (_creditLimitController.text.trim().isNotEmpty) {
      creditLimitPiasters = MoneyUtils.toPiasters(_creditLimitController.text.trim());
    }

    try {
      if (_isEditing) {
        await repo.updateCustomer(
          id: widget.customer!.id,
          name: name,
          phone: phone,
          notes: notes,
          creditLimitPiasters: creditLimitPiasters,
        );
      } else {
        await repo.addCustomer(
          name: name,
          phone: phone,
          notes: notes,
          creditLimitPiasters: creditLimitPiasters,
        );
      }

      if (mounted) {
        AppGlassToast.showSuccess(context, l10n.customerSaved);
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        AppGlassToast.showError(context, e.toString());
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

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.editCustomer : l10n.addCustomer),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Duplicate warning alert if detected
              if (_duplicateCustomer != null) ...[
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
                          '${l10n.duplicateCustomerWarning} (${_duplicateCustomer!.name})',
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

              // Customer Name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.customerName,
                  hintText: l10n.customerNameHint,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                ),
                textInputAction: TextInputAction.next,
                validator: (val) {
                  final text = val?.trim() ?? '';
                  if (text.isEmpty) return l10n.customerNameRequired;
                  if (text.length < 2) return l10n.customerNameTooShort;
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Number field
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: l10n.customerPhone,
                  hintText: l10n.customerPhoneHint,
                  prefixIcon: const Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  final text = val?.trim() ?? '';
                  if (text.isEmpty) return null; // phone is optional
                  if (!PhoneUtils.isValid(text)) {
                    return l10n.customerPhoneInvalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Credit Limit field
              TextFormField(
                controller: _creditLimitController,
                decoration: InputDecoration(
                  labelText: l10n.creditLimit,
                  hintText: l10n.creditLimitHint,
                  prefixIcon: const Icon(Icons.speed_rounded),
                  suffixText: l10n.currency,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Notes field
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: l10n.customerNotes,
                  hintText: l10n.customerNotesHint,
                  prefixIcon: const Icon(Icons.notes_rounded),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),

              // Save button
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(56),
                ),
                child: _isSaving
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                      )
                    : Text(
                        l10n.save,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
