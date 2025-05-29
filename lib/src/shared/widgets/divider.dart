import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:flutter/material.dart';

class VDivider extends StatelessWidget {
  const VDivider({
    super.key,
    this.height = 15,
    this.thickness = 1.5,
    this.color,
  });

  final double height;
  final Color? color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: thickness,
      decoration: BoxDecoration(
        color: color ?? context.appColor.grey.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
