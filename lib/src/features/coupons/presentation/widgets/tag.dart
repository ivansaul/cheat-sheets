import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:flutter/material.dart';

class CouponTag extends StatelessWidget {
  const CouponTag({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.appColor.grey,
          width: 0.5,
        ),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall
            ?.foregroundColor(context.appColor.grey),
      ),
    );
  }
}
