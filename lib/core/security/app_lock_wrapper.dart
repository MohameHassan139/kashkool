import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import 'pin_lock_screen.dart';
import 'security_service.dart';

/// Wraps the application to enforce PIN/biometric authentication on launch
/// and when returning from background after the timeout, plus shielding against recent apps preview.
class AppLockWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const AppLockWrapper({super.key, required this.child});

  @override
  ConsumerState<AppLockWrapper> createState() => _AppLockWrapperState();
}

class _AppLockWrapperState extends ConsumerState<AppLockWrapper>
    with WidgetsBindingObserver {
  bool _isInBackground = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final securityService = ref.read(securityServiceProvider);
    if (securityService.isAuthenticatingBiometrics) return;

    final lockNotifier = ref.read(appLockNotifierProvider.notifier);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        setState(() => _isInBackground = true);
        lockNotifier.onAppPaused();
        break;
      case AppLifecycleState.resumed:
        setState(() => _isInBackground = false);
        lockNotifier.onAppResumed();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLocked = ref.watch(appLockNotifierProvider);
    final direction = Directionality.maybeOf(context) ?? TextDirection.rtl;

    return Directionality(
      textDirection: direction,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.child,
          if (_isInBackground && isLocked)
            Positioned.fill(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.lock_rounded,
                    size: 64,
                    color: AppColors.neutralGrey,
                  ),
                ),
              ),
            ),
          if (isLocked)
            Positioned.fill(
              child: Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) => const PinLockScreen(mode: PinLockMode.unlock),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
