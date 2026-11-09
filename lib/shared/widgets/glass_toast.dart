import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Type of glass toast to display.
enum GlassToastType {
  success,
  error,
  info,
}

/// Utility for showing modern glassmorphism toasts/snackbars that auto-dismiss.
abstract final class AppGlassToast {
  /// Default auto-dismiss duration for standard operations (2.5 seconds).
  static const Duration defaultDuration = Duration(milliseconds: 2500);

  /// Auto-dismiss duration when an interactive action (like Undo) is present (4 seconds).
  static const Duration actionDuration = Duration(seconds: 4);

  /// Show a floating glass toast at the bottom of the screen.
  static void show(
    BuildContext context, {
    required String message,
    GlassToastType type = GlassToastType.success,
    Duration? duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    // Clear any previous snackbars immediately so messages never stack up
    messenger.clearSnackBars();

    final actualDuration = duration ??
        (actionLabel != null ? actionDuration : defaultDuration);

    messenger.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        duration: actualDuration,
        content: GlassToastWidget(
          message: message,
          type: type,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
      ),
    );
  }

  /// Show a success glass toast (e.g. Saved, Added, Updated, Closed).
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration? duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      context,
      message: message,
      type: GlassToastType.success,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Show an error or warning glass toast.
  static void showError(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(
      context,
      message: message,
      type: GlassToastType.error,
      duration: duration,
    );
  }

  /// Show an informative glass toast.
  static void showInfo(
    BuildContext context,
    String message, {
    Duration? duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      context,
      message: message,
      type: GlassToastType.info,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}

/// Glassmorphism styled widget for notification toasts.
class GlassToastWidget extends StatelessWidget {
  final String message;
  final GlassToastType type;
  final String? actionLabel;
  final VoidCallback? onAction;

  const GlassToastWidget({
    super.key,
    required this.message,
    this.type = GlassToastType.success,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final IconData icon;
    final Color accentColor;
    final Color iconBgColor;
    final Color textColor;
    final Color borderColor;
    final List<Color> gradientColors;

    switch (type) {
      case GlassToastType.success:
        icon = Icons.check_circle_rounded;
        accentColor = isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen;
        iconBgColor = accentColor.withValues(alpha: isDark ? 0.28 : 0.15);
        textColor = isDark ? Colors.white : const Color(0xFF064E3B);
        borderColor = isDark
            ? accentColor.withValues(alpha: 0.50)
            : const Color(0xFF86EFAC).withValues(alpha: 0.90);
        gradientColors = isDark
            ? [
                const Color(0xFF064E3B).withValues(alpha: 0.88),
                const Color(0xFF022C22).withValues(alpha: 0.82),
              ]
            : [
                const Color(0xFFF0FDF4).withValues(alpha: 0.95),
                const Color(0xFFDCFCE7).withValues(alpha: 0.90),
              ];
        break;

      case GlassToastType.error:
        icon = Icons.error_outline_rounded;
        accentColor = isDark ? AppColors.debtRedDark : AppColors.debtRed;
        iconBgColor = accentColor.withValues(alpha: isDark ? 0.28 : 0.15);
        textColor = isDark ? Colors.white : const Color(0xFF7F1D1D);
        borderColor = isDark
            ? accentColor.withValues(alpha: 0.50)
            : const Color(0xFFFCA5A5).withValues(alpha: 0.90);
        gradientColors = isDark
            ? [
                const Color(0xFF7F1D1D).withValues(alpha: 0.88),
                const Color(0xFF450A0A).withValues(alpha: 0.82),
              ]
            : [
                const Color(0xFFFEF2F2).withValues(alpha: 0.95),
                const Color(0xFFFEE2E2).withValues(alpha: 0.90),
              ];
        break;

      case GlassToastType.info:
        icon = Icons.info_outline_rounded;
        accentColor = isDark ? AppColors.primaryBlueDark : AppColors.primaryBlue;
        iconBgColor = accentColor.withValues(alpha: isDark ? 0.28 : 0.15);
        textColor = isDark ? Colors.white : const Color(0xFF0F172A);
        borderColor = isDark
            ? Colors.white.withValues(alpha: 0.25)
            : Colors.white.withValues(alpha: 0.85);
        gradientColors = isDark
            ? [
                const Color(0xFF1E293B).withValues(alpha: 0.88),
                const Color(0xFF0F172A).withValues(alpha: 0.82),
              ]
            : [
                const Color(0xFFF8FAFC).withValues(alpha: 0.95),
                const Color(0xFFF1F5F9).withValues(alpha: 0.90),
              ];
        break;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: gradientColors,
              ),
              border: Border.all(
                color: borderColor,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBgColor,
                  ),
                  child: Icon(
                    icon,
                    color: accentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (actionLabel != null && onAction != null) ...[
                  const SizedBox(width: 10),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        onAction!();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.18)
                              : Colors.white.withValues(alpha: 0.70),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.30)
                                : accentColor.withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          actionLabel!,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Convenience extension on [BuildContext] to show glass toasts.
extension GlassToastBuildContextX on BuildContext {
  /// Show a success glass toast.
  void showSuccessToast(
    String message, {
    Duration? duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    AppGlassToast.showSuccess(
      this,
      message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Show an error glass toast.
  void showErrorToast(
    String message, {
    Duration? duration,
  }) {
    AppGlassToast.showError(
      this,
      message,
      duration: duration,
    );
  }

  /// Show an informative glass toast.
  void showInfoToast(
    String message, {
    Duration? duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    AppGlassToast.showInfo(
      this,
      message,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
