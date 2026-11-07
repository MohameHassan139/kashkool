import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Quick amount selector chips (50, 100, 200, 500 EGP).
class QuickAmountChips extends StatelessWidget {
  final ValueChanged<int> onAmountSelected;

  const QuickAmountChips({
    super.key,
    required this.onAmountSelected,
  });

  static const List<int> _amounts = [50, 100, 200, 500];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _amounts.map((amt) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ActionChip(
                backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                side: BorderSide(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                label: Center(
                  child: Text(
                    '+$amt',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  onAmountSelected(amt);
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
