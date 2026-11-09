import 'package:flutter/material.dart';
import '../../../../core/utils/customer_rating.dart';
import 'rating_explanation_bottom_sheet.dart';

/// Compact interactive badge showing customer rating (dot + label).
/// Tapping opens the explanation sheet.
class CustomerRatingBadge extends StatelessWidget {
  final String customerName;
  final CustomerRatingResult rating;

  const CustomerRatingBadge({
    super.key,
    required this.customerName,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (ctx) => RatingExplanationBottomSheet(
            customerName: customerName,
            rating: rating,
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: rating.color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: rating.color.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: rating.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                rating.labelAr,
                style: TextStyle(
                  color: rating.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
