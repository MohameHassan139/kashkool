import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import 'security_service.dart';

enum PinLockMode {
  unlock,
  setup,
}

/// Screen presenting the 4-digit PIN keypad with biometric option and friendly feedback.
class PinLockScreen extends ConsumerStatefulWidget {
  final PinLockMode mode;
  final VoidCallback? onSuccess;
  final VoidCallback? onCancel;

  const PinLockScreen({
    super.key,
    this.mode = PinLockMode.unlock,
    this.onSuccess,
    this.onCancel,
  });

  @override
  ConsumerState<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends ConsumerState<PinLockScreen> {
  String _currentInput = '';
  String? _firstPin; // Used during setup mode for confirmation
  String? _errorMessage;
  bool _isChecking = false;
  bool _isBiometricRunning = false;

  @override
  void initState() {
    super.initState();
    if (widget.mode == PinLockMode.unlock) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkBiometricsAutoPrompt();
      });
    }
  }

  Future<void> _checkBiometricsAutoPrompt() async {
    if (_isBiometricRunning || _isChecking) return;
    final securityService = ref.read(securityServiceProvider);
    final bioEnabled = await securityService.isBiometricEnabled();
    final bioAvailable = await securityService.isBiometricsAvailable();
    if (bioEnabled && bioAvailable && mounted) {
      setState(() => _isBiometricRunning = true);
      try {
        final success = await securityService.authenticateWithBiometrics();
        if (success && mounted) {
          ref.read(appLockNotifierProvider.notifier).unlock();
          widget.onSuccess?.call();
        }
      } finally {
        if (mounted) {
          setState(() => _isBiometricRunning = false);
        }
      }
    }
  }

  void _onDigitPressed(String digit) {
    if (_isChecking || _currentInput.length >= 4) return;
    unawaited(HapticFeedback.lightImpact());

    setState(() {
      _currentInput += digit;
      _errorMessage = null;
    });

    if (_currentInput.length == 4) {
      _handleCompletedPin(_currentInput);
    }
  }

  void _onBackspacePressed() {
    if (_isChecking || _currentInput.isEmpty) return;
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      _errorMessage = null;
    });
  }

  Future<void> _handleCompletedPin(String pin) async {
    final securityService = ref.read(securityServiceProvider);

    if (widget.mode == PinLockMode.unlock) {
      setState(() => _isChecking = true);
      final isValid = await securityService.verifyPin(pin);
      if (!mounted) return;

      if (isValid) {
        unawaited(HapticFeedback.mediumImpact());
        ref.read(appLockNotifierProvider.notifier).unlock();
        widget.onSuccess?.call();
      } else {
        unawaited(HapticFeedback.heavyImpact());
        setState(() {
          _isChecking = false;
          _currentInput = '';
          _errorMessage = 'رمز الدخول غير صحيح، حاول تاني';
        });
      }
    } else {
      // Setup mode: two-step PIN confirmation
      if (_firstPin == null) {
        // First entry
        setState(() {
          _firstPin = pin;
          _currentInput = '';
          _errorMessage = null;
        });
      } else {
        // Confirm entry
        if (_firstPin == pin) {
          setState(() => _isChecking = true);
          await securityService.setPin(pin);
          if (!mounted) return;
          unawaited(HapticFeedback.mediumImpact());
          widget.onSuccess?.call();
        } else {
          unawaited(HapticFeedback.heavyImpact());
          setState(() {
            _firstPin = null;
            _currentInput = '';
            _errorMessage = 'الرمزان غير متطابقين، حاول من جديد';
          });
        }
      }
    }
  }

  Future<void> _onBiometricPressed() async {
    if (_isBiometricRunning || _isChecking) return;
    final securityService = ref.read(securityServiceProvider);
    final isAvailable = await securityService.isBiometricsAvailable();
    if (!isAvailable) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('البصمة غير متاحة أو غير مفعّلة في إعدادات جهازك'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    setState(() => _isBiometricRunning = true);
    try {
      final success = await securityService.authenticateWithBiometrics();
      if (success && mounted) {
        ref.read(appLockNotifierProvider.notifier).unlock();
        widget.onSuccess?.call();
      }
    } finally {
      if (mounted) {
        setState(() => _isBiometricRunning = false);
      }
    }
  }

  String get _titleText {
    if (widget.mode == PinLockMode.unlock) {
      return 'أهلاً بيك في كشكول 📒';
    }
    if (_firstPin == null) {
      return 'تعيين رمز دخول جديد';
    }
    return 'أعد كتابة الرمز للتأكيد';
  }

  String get _subtitleText {
    if (widget.mode == PinLockMode.unlock) {
      return 'أدخل رمز الدخول المكون من 4 أرقام';
    }
    if (_firstPin == null) {
      return 'اكتب 4 أرقام تفتكرهم عشان تقفل بيهم التطبيق';
    }
    return 'اكتب نفس الأرقام مرة تانية';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.rtl,
      child: Scaffold(
      appBar: widget.onCancel != null
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: widget.onCancel,
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              // App Icon / Lock Icon
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_rounded,
                  size: 38,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              // Header text
              Text(
                _titleText,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _subtitleText,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.neutralGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // PIN Dots (4 indicators)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFilled = index < _currentInput.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled
                          ? theme.colorScheme.primary
                          : (isDark ? const Color(0xFF374151) : Colors.grey.shade300),
                      border: Border.all(
                        color: isFilled
                            ? theme.colorScheme.primary
                            : (isDark ? const Color(0xFF4B5563) : Colors.grey.shade400),
                        width: 1.5,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Error message
              SizedBox(
                height: 24,
                child: _errorMessage != null
                    ? Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: AppColors.debtRed,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : null,
              ),

              const Spacer(flex: 1),

              // Keypad (Grid of 1-9, Biometric/Empty, 0, Backspace)
              _buildKeypad(),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    ),   // Scaffold
    );   // Directionality
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        _buildKeypadRow(['1', '2', '3']),
        const SizedBox(height: 14),
        _buildKeypadRow(['4', '5', '6']),
        const SizedBox(height: 14),
        _buildKeypadRow(['7', '8', '9']),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Left action: Biometrics (if unlock mode)
            widget.mode == PinLockMode.unlock
                ? _buildKeypadAction(
                    icon: Icons.fingerprint_rounded,
                    onTap: _onBiometricPressed,
                    tooltip: 'بصمة الإصبع',
                  )
                : const SizedBox(width: 72, height: 72),
            // Middle: 0
            _buildKeypadDigit('0'),
            // Right action: Backspace
            _buildKeypadAction(
              icon: Icons.backspace_outlined,
              onTap: _onBackspacePressed,
              tooltip: 'مسح',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeypadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map(_buildKeypadDigit).toList(),
    );
  }

  Widget _buildKeypadDigit(String digit) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: 72,
      height: 72,
      child: Material(
        color: isDark ? const Color(0xFF1F2937) : Colors.grey.shade100,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _onDigitPressed(digit),
          child: Center(
            child: Text(
              digit,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadAction({
    required IconData icon,
    required VoidCallback onTap,
    String? tooltip,
  }) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 72,
      height: 72,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Icon(icon, size: 28, color: theme.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
