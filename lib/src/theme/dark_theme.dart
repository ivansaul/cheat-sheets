import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: HexColor('#1C1A29'),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('#1C1A29'),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
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
  scaffoldBackgroundColor: HexColor('#1C1A29'),
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
        bodyColor: HexColor('#CBD5E1'),
        displayColor: HexColor('#CBD5E1'),
      ),
);
