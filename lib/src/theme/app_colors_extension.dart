import 'package:flutter/material.dart';

@immutable
class ColorsExtension extends ThemeExtension<ColorsExtension> {
  final Color grey;
  final Color orange;
  final Color green;

  final Color backgroundSecondary;
  final Color backgroundGroupPrimary;
  final Color backgroundGroupSecondary;

  const ColorsExtension({
    required this.grey,
    required this.orange,
    required this.green,
    required this.backgroundSecondary,
    required this.backgroundGroupPrimary,
    required this.backgroundGroupSecondary,
  });

  @override
  ThemeExtension<ColorsExtension> copyWith({
    Color? grey,
    Color? orange,
    Color? green,
    Color? backgroundSecondary,
    Color? backgroundGroupPrimary,
    Color? backgroundGroupSecondary,
  }) {
    return ColorsExtension(
      grey: grey ?? this.grey,
      orange: orange ?? this.orange,
      green: green ?? this.green,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundGroupPrimary:
          backgroundGroupPrimary ?? this.backgroundGroupPrimary,
      backgroundGroupSecondary:
          backgroundGroupSecondary ?? this.backgroundGroupSecondary,
    );
  }

  @override
  ThemeExtension<ColorsExtension> lerp(
      covariant ThemeExtension<ColorsExtension>? other, double t) {
    if (other is! ColorsExtension) return this;

    return ColorsExtension(
      grey: Color.lerp(grey, other.grey, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      green: Color.lerp(green, other.green, t)!,
      backgroundSecondary:
          Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      backgroundGroupPrimary:
          Color.lerp(backgroundGroupPrimary, other.backgroundGroupPrimary, t)!,
      backgroundGroupSecondary: Color.lerp(
          backgroundGroupSecondary, other.backgroundGroupSecondary, t)!,
    );
  }
}

@immutable
abstract class AppColorExtension {
  static const light = ColorsExtension(
    grey: Color(0xff8E8E93),
    orange: Color(0xffFF9500),
    green: Color(0xff34C759),
    backgroundSecondary: Color(0xffF2F2F7),
    backgroundGroupPrimary: Color(0xffF2F2F7),
    backgroundGroupSecondary: Color(0xffFFFFFF),
  );

  static const dark = ColorsExtension(
    grey: Color(0xff8E8E93),
    orange: Color(0xffFF9F0A),
    green: Color(0xff30D158),
    backgroundSecondary: Color(0xff1C1C1E),
    backgroundGroupPrimary: Color(0xff000000),
    backgroundGroupSecondary: Color(0xff1C1C1E),
  );
}
