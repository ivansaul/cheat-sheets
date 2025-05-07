import 'package:flutter/material.dart';

@immutable
class ColorsExtension extends ThemeExtension<ColorsExtension> {
  final Color backgroundSecondary;

  const ColorsExtension({
    required this.backgroundSecondary,
  });

  @override
  ThemeExtension<ColorsExtension> copyWith({
    Color? backgroundSecondary,
  }) {
    return ColorsExtension(
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
    );
  }

  @override
  ThemeExtension<ColorsExtension> lerp(
      covariant ThemeExtension<ColorsExtension>? other, double t) {
    if (other is! ColorsExtension) return this;

    return ColorsExtension(
      backgroundSecondary:
          Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
    );
  }
}

@immutable
abstract class AppColorExtension {
  static const light = ColorsExtension(
    backgroundSecondary: Color(0xffF2F2F7),
  );

  static const dark = ColorsExtension(
    backgroundSecondary: Color(0xff1C1C1E),
  );
}
