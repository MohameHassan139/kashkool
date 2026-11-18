import 'package:flutter/material.dart';

/// A [Text] that is safe for translated, user-generated and long strings.
///
/// Every instance has a bounded line count and an ellipsis, so a new language
/// (or a very long customer name) can never push siblings out of a [Row].
class AdaptiveText extends StatelessWidget {
  const AdaptiveText(
    this.data, {
    super.key,
    this.style,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.textDirection,
    this.semanticsLabel,
  });

  final String data;
  final TextStyle? style;
  final int maxLines;
  final TextOverflow overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textDirection: textDirection,
      semanticsLabel: semanticsLabel,
    );
  }
}

/// A single-line amount that shrinks to fit instead of overflowing.
///
/// Inside a [Row] or [Flex], wrap this widget in [Flexible] or [Expanded]:
///
/// ```dart
/// Row(children: [
///   const AdaptiveText('الإجمالي', maxLines: 1),
///   Flexible(child: AdaptiveAmountText(amount, style: bigStyle)),
/// ])
/// ```
class AdaptiveAmountText extends StatelessWidget {
  const AdaptiveAmountText(
    this.data, {
    super.key,
    this.style,
    this.alignment = AlignmentDirectional.centerStart,
  });

  final String data;
  final TextStyle? style;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: Text(
        data,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style ?? Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
