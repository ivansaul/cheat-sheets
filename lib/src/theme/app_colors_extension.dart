// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color brandWhite;
  final Color brandBlack;
  final Color brandBlue;
  final Color grey50;
  final Color grey100;
  final Color grey150;
  final Color grey200;

  AppColorsExtension({
    required this.brandWhite,
    required this.brandBlack,
    required this.brandBlue,
    required this.grey50,
    required this.grey100,
    required this.grey150,
    required this.grey200,
  });

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;

    return AppColorsExtension(
      brandWhite: Color.lerp(brandWhite, other.brandWhite, t)!,
      brandBlack: Color.lerp(brandBlack, other.brandBlack, t)!,
      brandBlue: Color.lerp(brandBlue, other.brandBlue, t)!,
      grey50: Color.lerp(grey50, other.grey50, t)!,
      grey100: Color.lerp(grey100, other.grey100, t)!,
      grey150: Color.lerp(grey150, other.grey150, t)!,
      grey200: Color.lerp(grey200, other.grey200, t)!,
    );
  }

  @override
  AppColorsExtension copyWith({
    Color? brandWhite,
    Color? brandBlack,
    Color? brandBlue,
    Color? grey50,
    Color? grey100,
    Color? grey150,
    Color? grey200,
  }) {
    return AppColorsExtension(
      brandWhite: brandWhite ?? this.brandWhite,
      brandBlack: brandBlack ?? this.brandBlack,
      brandBlue: brandBlue ?? this.brandBlue,
      grey50: grey50 ?? this.grey50,
      grey100: grey100 ?? this.grey100,
      grey150: grey150 ?? this.grey150,
      grey200: grey200 ?? this.grey200,
    );
  }
}
