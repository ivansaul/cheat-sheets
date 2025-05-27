import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:flutter/material.dart';

class CouponBadge extends StatelessWidget {
  const CouponBadge({
    super.key,
    required this.child,
    this.color,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8),
    ),
    this.padding,
  });

  final Widget child;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color ?? context.appColor.backgroundSecondary,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
