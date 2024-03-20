import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/theme/app_colors_extension.dart';
import 'package:cheat_sheets/src/theme/app_text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool _light;

  AppTheme(this._light);

  ///
  /// App colors
  ///

  AppColorsExtension get _colors {
    return AppColorsExtension(
      brandWhite: _light ? const Color(0xffF1F5F9) : const Color(0xff1C1A29),
      brandBlack: _light ? const Color(0xff1E293B) : const Color(0xffFFFFFF),
      brandBlue: _light ? const Color(0xff448AFF) : const Color(0xff448AFF),
      grey50: _light ? const Color(0xffFFFFFF) : const Color(0xff1E293B),
      grey100: _light ? const Color(0xffDDDDDD) : const Color(0xff283B59),
      grey150: _light ? const Color(0xff94A3B8) : const Color(0xff64748B),
      grey200: _light ? const Color(0xff334155) : const Color(0xffCBD5E1),
    );
  }

  ///
  /// App Text Theme
  ///

  TextStyle _heading(int n) => TextStyle(
        color: _colors.brandBlack,
        fontSize: switch (n) {
          1 => 32,
          2 => 24,
          3 => 17,
          _ => 17,
        },
      );

  TextStyle _body(int n) => TextStyle(
        color: _colors.brandBlack,
        fontSize: switch (n) {
          1 => 16,
          2 => 15,
          _ => 15,
        },
      );

  AppTextThemeExtension get _textTheme {
    return AppTextThemeExtension(
      heading1Bold: _heading(1).tsBold(),
      heading1SemiBold: _heading(1).tsSemibold(),
      heading1Regular: _body(1).tsRegular(),
      heading2Bold: _heading(2).tsBold(),
      heading2SemiBold: _heading(2).tsSemibold(),
      heading2Regular: _heading(2).tsRegular(),
      heading3Bold: _heading(3).tsBold(),
      heading3SemiBold: _heading(3).tsSemibold(),
      heading3Regular: _heading(3).tsRegular(),
      body1Bold: _body(1).tsBold(),
      body1SemiBold: _body(1).tsSemibold(),
      body1Regular: _body(1).tsRegular(),
      body2Bold: _body(2).tsBold(),
      body2SemiBold: _body(2).tsSemibold(),
      body2Medium: _body(2).tsMedium(),
      body2Regular: _body(2).tsRegular(),
    );
  }

  ///
  /// App Theme
  ///

  ThemeData get theme {
    return ThemeData(
      fontFamily: GoogleFonts.roboto().fontFamily,
    ).copyWith(
      colorScheme:
          _light ? const ColorScheme.light() : const ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor: _colors.brandWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: _colors.brandBlue,
          size: 22,
        ),
        actionsIconTheme: IconThemeData(
          color: _colors.brandBlue,
          size: 22,
        ),
        titleTextStyle: _textTheme.heading2Bold,
      ),
      scaffoldBackgroundColor: _colors.brandWhite,
      iconTheme: IconThemeData(
        color: _colors.brandBlack,
        size: 22,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: _colors.grey150,
      ),
      extensions: [
        _colors,
        _textTheme,
      ],
    );
  }
}
