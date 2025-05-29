import 'package:cheat_sheets/src/features/coupons/presentation/widgets/tag.dart';
import 'package:flutter/material.dart';

class CouponTagsRow extends StatelessWidget {
  const CouponTagsRow({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...tags.map((tag) => CouponTag(text: tag)),
      ],
    );
  }
}
