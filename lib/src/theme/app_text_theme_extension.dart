// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  final TextStyle heading1Bold;
  final TextStyle heading1SemiBold;
  final TextStyle heading1Regular;
  final TextStyle heading2Bold;
  final TextStyle heading2SemiBold;
  final TextStyle heading2Regular;
  final TextStyle heading3Bold;
  final TextStyle heading3SemiBold;
  final TextStyle heading3Regular;
  final TextStyle body1Bold;
  final TextStyle body1SemiBold;
  final TextStyle body1Regular;
  final TextStyle body2Bold;
  final TextStyle body2SemiBold;
  final TextStyle body2Medium;
  final TextStyle body2Regular;

  AppTextThemeExtension({
    required this.heading1Bold,
    required this.heading1SemiBold,
    required this.heading1Regular,
    required this.heading2Bold,
    required this.heading2SemiBold,
    required this.heading2Regular,
    required this.heading3Bold,
    required this.heading3SemiBold,
    required this.heading3Regular,
    required this.body1Bold,
    required this.body1SemiBold,
    required this.body1Regular,
    required this.body2Bold,
    required this.body2SemiBold,
    required this.body2Medium,
    required this.body2Regular,
  });

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
    covariant ThemeExtension<AppTextThemeExtension>? other,
    double t,
  ) {
    if (other is! AppTextThemeExtension) return this;
    return AppTextThemeExtension(
      heading1Bold: TextStyle.lerp(heading1Bold, other.heading1Bold, t)!,
      heading1SemiBold:
          TextStyle.lerp(heading1SemiBold, other.heading1SemiBold, t)!,
      heading1Regular:
          TextStyle.lerp(heading1Regular, other.heading1Regular, t)!,
      heading2Bold: TextStyle.lerp(heading2Bold, other.heading2Bold, t)!,
      heading2SemiBold:
          TextStyle.lerp(heading2SemiBold, other.heading2SemiBold, t)!,
      heading2Regular:
          TextStyle.lerp(heading2Regular, other.heading2Regular, t)!,
      heading3Bold: TextStyle.lerp(heading3Bold, other.heading3Bold, t)!,
      heading3SemiBold:
          TextStyle.lerp(heading3SemiBold, other.heading3SemiBold, t)!,
      heading3Regular:
          TextStyle.lerp(heading3Regular, other.heading3Regular, t)!,
      body1Bold: TextStyle.lerp(body1Bold, other.body1Bold, t)!,
      body1SemiBold: TextStyle.lerp(body1SemiBold, other.body1SemiBold, t)!,
      body1Regular: TextStyle.lerp(body1Regular, other.body1Regular, t)!,
      body2Bold: TextStyle.lerp(body2Bold, other.body2Bold, t)!,
      body2SemiBold: TextStyle.lerp(body2SemiBold, other.body2SemiBold, t)!,
      body2Medium: TextStyle.lerp(body2Medium, other.body2Medium, t)!,
      body2Regular: TextStyle.lerp(body2Regular, other.body2Regular, t)!,
    );
  }

  @override
  AppTextThemeExtension copyWith({
    TextStyle? heading1Bold,
    TextStyle? heading1SemiBold,
    TextStyle? heading1Regular,
    TextStyle? heading2Bold,
    TextStyle? heading2SemiBold,
    TextStyle? heading2Regular,
    TextStyle? heading3Bold,
    TextStyle? heading3SemiBold,
    TextStyle? heading3Regular,
    TextStyle? body1Bold,
    TextStyle? body1SemiBold,
    TextStyle? body1Regular,
    TextStyle? body2Bold,
    TextStyle? body2SemiBold,
    TextStyle? body2Medium,
    TextStyle? body2Regular,
  }) {
    return AppTextThemeExtension(
      heading1Bold: heading1Bold ?? this.heading1Bold,
      heading1SemiBold: heading1SemiBold ?? this.heading1SemiBold,
      heading1Regular: heading1Regular ?? this.heading1Regular,
      heading2Bold: heading2Bold ?? this.heading2Bold,
      heading2SemiBold: heading2SemiBold ?? this.heading2SemiBold,
      heading2Regular: heading2Regular ?? this.heading2Regular,
      heading3Bold: heading3Bold ?? this.heading3Bold,
      heading3SemiBold: heading3SemiBold ?? this.heading3SemiBold,
      heading3Regular: heading3Regular ?? this.heading3Regular,
      body1Bold: body1Bold ?? this.body1Bold,
      body1SemiBold: body1SemiBold ?? this.body1SemiBold,
      body1Regular: body1Regular ?? this.body1Regular,
      body2Bold: body2Bold ?? this.body2Bold,
      body2SemiBold: body2SemiBold ?? this.body2SemiBold,
      body2Medium: body2Medium ?? this.body2Medium,
      body2Regular: body2Regular ?? this.body2Regular,
    );
  }
}
