import 'package:cheat_sheets/src/theme/app_colors_extension.dart';
import 'package:cheat_sheets/src/theme/app_text_theme_extension.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>()!;

  AppTextThemeExtension get textTheme =>
      Theme.of(this).extension<AppTextThemeExtension>()!;
}
