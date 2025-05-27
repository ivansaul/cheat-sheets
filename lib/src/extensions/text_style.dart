import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);
  TextStyle semibold() => copyWith(fontWeight: FontWeight.w600);
  TextStyle fontWeight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle fontSize(double size) => copyWith(fontSize: size);
  TextStyle foregroundColor(Color color) => copyWith(color: color);
}
