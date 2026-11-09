import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/customer_rating.dart';
import '../../../../l10n/l10n.dart';

/// Bottom sheet explaining the customer's financial rating to the shopkeeper.
class RatingExplanationBottomSheet extends StatelessWidget {
  final String customerName;
  final CustomerRatingResult rating;

  const RatingExplanationBottomSheet({
    super.key,
    required this.customerName,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Grab handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // Header with badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: rating.color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_user_rounded,
                    color: rating.color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L10n.t.ratingExplanationBottomSheet1(customerName),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: rating.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            rating.labelAr,
                            style: TextStyle(
                              color: rating.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Reason Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: rating.color.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10n.t.ratingExplanationBottomSheet2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.neutralGrey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    rating.explanation,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // System explanation legend for merchant
            Text(
              L10n.t.ratingExplanationBottomSheet3,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10),

            _buildLegendItem(
              color: AppColors.paymentGreen,
              title: L10n.t.ratingExplanationBottomSheet4,
              desc: L10n.t.ratingExplanationBottomSheet5,
            ),
            const SizedBox(height: 8),
            _buildLegendItem(
              color: AppColors.warningAmber,
              title: L10n.t.ratingExplanationBottomSheet6,
              desc: L10n.t.ratingExplanationBottomSheet7,
            ),
            const SizedBox(height: 8),
            _buildLegendItem(
              color: AppColors.debtRed,
              title: L10n.t.ratingExplanationBottomSheet8,
              desc: L10n.t.ratingExplanationBottomSheet9,
            ),
            const SizedBox(height: 8),
            _buildLegendItem(
              color: const Color(0xFF94A3B8),
              title: L10n.t.ratingExplanationBottomSheet10,
              desc: L10n.t.ratingExplanationBottomSheet11,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(L10n.t.ratingExplanationBottomSheet12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.neutralGreyDark, fontSize: 13),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                TextSpan(text: desc),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
