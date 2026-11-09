import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/credit_limit.dart';
import '../../../core/utils/money.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../../customers/data/customer_repository.dart';
import '../data/transaction_repository.dart';
import 'widgets/numeric_keypad.dart';
import 'widgets/quick_amount_chips.dart';

/// Interactive bottom sheet for recording debts ("عليه") and payments ("دفع") in seconds.
class AddTransactionBottomSheet extends ConsumerStatefulWidget {
  final PartyType partyType;
  final String partyId;
  final String partyName;
  final int currentBalancePiasters;
  final int? creditLimitPiasters;
  final TransactionType initialType;

  const AddTransactionBottomSheet({
    super.key,
    required this.partyType,
    required this.partyId,
    required this.partyName,
    required this.currentBalancePiasters,
    this.creditLimitPiasters,
    required this.initialType,
  });

  @override
  ConsumerState<AddTransactionBottomSheet> createState() => _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends ConsumerState<AddTransactionBottomSheet> {
  late TransactionType _type;
  late int? _currentCreditLimit;
  PaymentMethod _method = PaymentMethod.cash;
  DateTime _occurredAt = DateTime.now();

  String _amountString = '';
  final _noteController = TextEditingController();
  String? _selectedPhotoPath;

  bool _isSaving = false;
  bool _isListening = false;
  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
    _currentCreditLimit = widget.creditLimitPiasters;
  }

  @override
  void dispose() {
    _noteController.dispose();
    _speech.stop();
    super.dispose();
  }

  void _onKeyPress(String key) {
    if (key == '.' && _amountString.contains('.')) return;
    if (_amountString == '0' && key != '.') {
      setState(() => _amountString = key);
      return;
    }

    // Limit decimal places to 2
    if (_amountString.contains('.')) {
      final parts = _amountString.split('.');
      if (parts.length > 1 && parts[1].length >= 2) return;
    }

    // Limit max digits
    if (_amountString.length >= 8) return;

    setState(() {
      _amountString += key;
    });
  }

  void _onBackspace() {
    if (_amountString.isNotEmpty) {
      setState(() {
        _amountString = _amountString.substring(0, _amountString.length - 1);
      });
    }
  }

  void _onClear() {
    setState(() {
      _amountString = '';
    });
  }

  void _onQuickAmountSelected(int amount) {
    final current = MoneyUtils.toPiasters(_amountString);
    final additional = amount * MoneyUtils.piastersPerPound;
    final total = current + additional;
    final pounds = total / MoneyUtils.piastersPerPound;

    setState(() {
      _amountString = pounds % 1 == 0 ? pounds.toInt().toString() : pounds.toStringAsFixed(2);
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _occurredAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      locale: const Locale('ar'),
    );
    if (picked != null) {
      setState(() {
        _occurredAt = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _occurredAt.hour,
          _occurredAt.minute,
        );
      });
    }
  }

  String _formatDateLabel(AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(_occurredAt.year, _occurredAt.month, _occurredAt.day);

    if (dateOnly == today) {
      return l10n.today;
    } else if (dateOnly == today.subtract(const Duration(days: 1))) {
      return l10n.yesterday;
    } else {
      return DateFormat('yyyy/MM/dd').format(_occurredAt);
    }
  }

  Future<void> _toggleVoiceDictation(AppLocalizations l10n) async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      return;
    }

    try {
      final available = await _speech.initialize(
        onError: (val) {
          if (mounted) setState(() => _isListening = false);
        },
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            if (mounted) setState(() => _isListening = false);
          }
        },
      );

      if (available && mounted) {
        setState(() => _isListening = true);
        await _speech.listen(
          listenOptions: stt.SpeechListenOptions(
            localeId: 'ar_EG',
            listenMode: stt.ListenMode.dictation,
          ),
          onResult: (result) {
            if (mounted) {
              setState(() {
                _noteController.text = result.recognizedWords;
              });
            }
          },
        );
      } else {
        if (mounted) {
          AppGlassToast.showInfo(context, l10n.speechNotAvailable);
        }
      }
    } catch (_) {
      if (mounted) {
        AppGlassToast.showInfo(context, l10n.speechNotAvailable);
      }
    }
  }

  Future<void> _pickPhoto() async {
    final l10n = AppLocalizations.of(context)!;
    final picker = ImagePicker();

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: Text(l10n.camera),
              onTap: () => Navigator.of(ctx).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: Text(l10n.gallery),
              onTap: () => Navigator.of(ctx).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final file = await picker.pickImage(source: source, imageQuality: 70);
      if (file != null && mounted) {
        setState(() {
          _selectedPhotoPath = file.path;
        });
      }
    }
  }

  Future<int?> _showChangeLimitDialog(BuildContext context, int currentLimit) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(
      text: (currentLimit / MoneyUtils.piastersPerPound).toStringAsFixed(0),
    );

    final res = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.changeLimit),
        content: SingleChildScrollView(
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n.newCreditLimit,
              suffixText: l10n.currency,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final newPiasters = MoneyUtils.toPiasters(controller.text.trim());
              Navigator.of(ctx).pop(newPiasters > 0 ? newPiasters : null);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );

    return res;
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final piasters = MoneyUtils.toPiasters(_amountString);

    if (piasters <= 0) {
      AppGlassToast.showError(context, l10n.amountRequired);
      return;
    }

    // Check overpayment warning
    if (_type == TransactionType.payment &&
        widget.currentBalancePiasters > 0 &&
        piasters > widget.currentBalancePiasters) {
      final difference = piasters - widget.currentBalancePiasters;
      final proceed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.overpaymentTitle),
          content: Text(
            l10n.overpaymentMessage(
              MoneyUtils.formatMoney(piasters),
              MoneyUtils.formatMoney(widget.currentBalancePiasters),
              MoneyUtils.formatMoney(difference),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.paymentGreen,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.overpaymentConfirm),
            ),
          ],
        ),
      );

      if (proceed != true) return;
    }

    // Check credit limit warning for debts (customers only)
    if (widget.partyType == PartyType.customer &&
        _type == TransactionType.debt &&
        CreditLimitUtils.willExceed(
          currentBalancePiasters: widget.currentBalancePiasters,
          addedDebtPiasters: piasters,
          limitPiasters: _currentCreditLimit,
        )) {
      if (!mounted) return;
      final newTotal = widget.currentBalancePiasters + piasters;
      final action = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.debtRed),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.creditLimitWarningTitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: Text(
            l10n.creditLimitExceededDialog(
              widget.partyName,
              MoneyUtils.formatMoney(newTotal),
              MoneyUtils.formatMoney(_currentCreditLimit!),
            ),
            style: const TextStyle(fontSize: 16),
          ),
          actionsOverflowDirection: VerticalDirection.down,
          actionsOverflowButtonSpacing: 8,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop('cancel'),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop('change_limit'),
              child: Text(l10n.changeLimit),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.debtRed,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(ctx).pop('save_anyway'),
              child: Text(l10n.saveAnyway),
            ),
          ],
        ),
      );

      if (action == 'change_limit' && mounted) {
        final newLimit = await _showChangeLimitDialog(context, _currentCreditLimit!);
        if (newLimit != null) {
          setState(() => _currentCreditLimit = newLimit);
          if (widget.partyType == PartyType.customer) {
            final customerRepo = ref.read(customerRepositoryProvider);
            final customerWithBal = await customerRepo.getCustomerWithBalance(widget.partyId);
            if (customerWithBal != null) {
              await customerRepo.updateCustomer(
                id: widget.partyId,
                name: customerWithBal.customer.name,
                phone: customerWithBal.customer.phone,
                notes: customerWithBal.customer.notes,
                creditLimitPiasters: newLimit,
              );
            }
          }
        }
        return;
      } else if (action != 'save_anyway') {
        return;
      }
    }

    setState(() => _isSaving = true);
    final repo = ref.read(transactionRepositoryProvider);

    try {
      String? persistentPhoto;
      if (_selectedPhotoPath != null) {
        persistentPhoto = await repo.persistPhoto(_selectedPhotoPath!);
      }

      final txId = await repo.addTransaction(
        partyType: widget.partyType,
        partyId: widget.partyId,
        type: _type,
        amountPiasters: piasters,
        method: _type == TransactionType.payment ? _method : null,
        note: _noteController.text.trim().isNotEmpty ? _noteController.text.trim() : null,
        photoPath: persistentPhoto,
        occurredAt: _occurredAt,
      );

      await HapticFeedback.mediumImpact();

      if (mounted) {
        Navigator.of(context).pop();

        // Show Glass Toast with 4-second Undo action that auto-dismisses smoothly
        AppGlassToast.showSuccess(
          context,
          l10n.transactionSaved,
          actionLabel: l10n.undo,
          onAction: () async {
            await repo.undoTransaction(txId);
            await HapticFeedback.mediumImpact();
            if (mounted) {
              AppGlassToast.showInfo(context, l10n.transactionUndone);
            }
          },
        );
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isDebt = _type == TransactionType.debt;
    final accentColor = isDebt ? AppColors.debtRed : AppColors.paymentGreen;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Grab handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 6),
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Title Bar with Type Selector Toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    // Type selector segment
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            // عليه (Debt)
                            Expanded(
                              child: InkWell(
                                onTap: () => setState(() => _type = TransactionType.debt),
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isDebt ? AppColors.debtRed : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    widget.partyType == PartyType.supplier
                                        ? l10n.iOweHim
                                        : l10n.debt,
                                    style: TextStyle(
                                      color: isDebt ? Colors.white : AppColors.neutralGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // دفع (Payment)
                            Expanded(
                              child: InkWell(
                                onTap: () => setState(() => _type = TransactionType.payment),
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: !isDebt ? AppColors.paymentGreen : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    widget.partyType == PartyType.supplier
                                        ? l10n.iPaidHim
                                        : l10n.payment,
                                    style: TextStyle(
                                      color: !isDebt ? Colors.white : AppColors.neutralGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Huge Amount Display
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _amountString.isEmpty ? '0' : _amountString,
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.currency,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.neutralGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Quick Amount Chips
              QuickAmountChips(onAmountSelected: _onQuickAmountSelected),

              // Payment Method Choice Chips (if type == payment)
              if (!isDebt) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ChoiceChip(
                          label: Text(l10n.methodCash),
                          selected: _method == PaymentMethod.cash,
                          onSelected: (_) => setState(() => _method = PaymentMethod.cash),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Text(l10n.methodInstapay),
                          selected: _method == PaymentMethod.instapay,
                          onSelected: (_) => setState(() => _method = PaymentMethod.instapay),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Text(l10n.methodWallet),
                          selected: _method == PaymentMethod.wallet,
                          onSelected: (_) => setState(() => _method = PaymentMethod.wallet),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Text(l10n.methodOther),
                          selected: _method == PaymentMethod.other,
                          onSelected: (_) => setState(() => _method = PaymentMethod.other),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Secondary Row: Date picker, Note, Voice dictation, and Photo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    // Date button
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        minimumSize: const Size(0, 44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.calendar_today_rounded, size: 16),
                      label: Text(
                        _formatDateLabel(l10n),
                        style: const TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: _pickDate,
                    ),
                    const SizedBox(width: 8),

                    // Note Input field with integrated mic & photo buttons
                    Expanded(
                      child: TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          hintText: l10n.noteOptional,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          isDense: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
                                  size: 20,
                                  color: _isListening ? AppColors.debtRed : null,
                                ),
                                tooltip: l10n.voiceDictation,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: () => _toggleVoiceDictation(l10n),
                              ),
                              IconButton(
                                icon: Icon(
                                  _selectedPhotoPath != null ? Icons.photo_rounded : Icons.camera_alt_outlined,
                                  size: 20,
                                  color: _selectedPhotoPath != null ? accentColor : null,
                                ),
                                tooltip: l10n.attachPhoto,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: _pickPhoto,
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Selected photo preview thumbnail if attached
              if (_selectedPhotoPath != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_selectedPhotoPath!),
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.attachPhoto,
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel_rounded, color: AppColors.debtRed),
                        tooltip: l10n.removePhoto,
                        onPressed: () => setState(() => _selectedPhotoPath = null),
                      ),
                    ],
                  ),
                ),
              ],

              // Custom Numeric Keypad
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: NumericKeypad(
                  onKeyPress: _onKeyPress,
                  onBackspace: _onBackspace,
                  onClear: _onClear,
                ),
              ),

              // Save Button (min 56dp height)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
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
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
