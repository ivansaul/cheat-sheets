import 'package:cheat_sheets/src/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  double get navigationBarHeight => kToolbarHeight + padding.top;

  ColorsExtension get appColor => Theme.of(this).extension<ColorsExtension>()!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Brightness get brightness => Theme.of(this).brightness;
}
