import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom large numeric keypad designed specifically for rapid entry in shop environments.
class NumericKeypad extends StatelessWidget {
  final ValueChanged<String> onKeyPress;
  final VoidCallback onBackspace;
  final VoidCallback onClear;

  const NumericKeypad({
    super.key,
    required this.onKeyPress,
    required this.onBackspace,
    required this.onClear,
  });

  Widget _buildKey(BuildContext context, String label, {VoidCallback? customTap, VoidCallback? longPress}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              HapticFeedback.selectionClick();
              if (customTap != null) {
                customTap();
              } else {
                onKeyPress(label);
              }
            },
            onLongPress: () {
              if (longPress != null) {
                HapticFeedback.heavyImpact();
                longPress();
              }
            },
            child: Container(
              height: 58,
              alignment: Alignment.center,
              child: Text(
                label,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionKey(BuildContext context, IconData icon, VoidCallback onTap, {VoidCallback? onLongPress}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              HapticFeedback.lightImpact();
              onTap();
            },
            onLongPress: () {
              if (onLongPress != null) {
                HapticFeedback.heavyImpact();
                onLongPress();
              }
            },
            child: Container(
              height: 58,
              alignment: Alignment.center,
              child: Icon(icon, size: 28),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            _buildKey(context, '1'),
            _buildKey(context, '2'),
            _buildKey(context, '3'),
          ],
        ),
        Row(
          children: [
            _buildKey(context, '4'),
            _buildKey(context, '5'),
            _buildKey(context, '6'),
          ],
        ),
        Row(
          children: [
            _buildKey(context, '7'),
            _buildKey(context, '8'),
            _buildKey(context, '9'),
          ],
        ),
        Row(
          children: [
            _buildKey(context, '.'),
            _buildKey(context, '0'),
            _buildActionKey(
              context,
              Icons.backspace_outlined,
              onBackspace,
              onLongPress: onClear,
            ),
          ],
        ),
      ],
    );
  }
}
