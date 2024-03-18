import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: HexColor('#F1F5F9'),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: HexColor('#1E293B'),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('#F1F5F9'),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: HexColor('#1E293B'),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    scrolledUnderElevation: 0,
    actionsIconTheme: const IconThemeData(
      color: Colors.blueAccent,
    ),
    iconTheme: const IconThemeData(
      color: Colors.blueAccent,
      size: 22,
    ),
  ),
  scaffoldBackgroundColor: HexColor('#F5F5F5'),
  iconTheme: IconThemeData(
    color: HexColor('#1E293B'),
  ),
  textTheme: GoogleFonts.robotoTextTheme()
      .copyWith(
        bodySmall: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      )
      .apply(
        fontFamily: GoogleFonts.roboto().fontFamily,
        bodyColor: HexColor('#1E293B'),
        displayColor: HexColor('#1E293B'),
      ),
);
