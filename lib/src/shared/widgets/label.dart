import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final IconData icon;
  final String text;
  final double spacing;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? iconSize;

  const Label({
    super.key,
    required this.icon,
    required this.text,
    this.spacing = 8,
    this.textStyle,
    this.iconColor,
    this.iconSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: spacing,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
