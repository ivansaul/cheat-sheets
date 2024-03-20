import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle tsBold() => copyWith(fontWeight: FontWeight.bold);
  TextStyle tsSemibold() => copyWith(fontWeight: FontWeight.w600);
  TextStyle tsMedium() => copyWith(fontWeight: FontWeight.w500);
  TextStyle tsRegular() => copyWith(fontWeight: FontWeight.normal);
  TextStyle tsSize(double size) => copyWith(fontSize: size);
  TextStyle tsColor(Color color) => copyWith(color: color);
}
