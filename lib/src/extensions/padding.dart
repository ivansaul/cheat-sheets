import 'package:flutter/material.dart';

extension PaddingX on Widget {
  Padding padding(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Padding paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );

  Padding paddingH(double value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );

  Padding paddingV(double value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );

  Padding paddingHV({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );
}
