import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color lightAqua = Color(0xFFCDE8E5);
  static const Color veryLightBlue = Color(0xFFEEF7FF);
  static const Color desaturatedCyan = Color(0xFF7AB2B2);
  static const Color desaturatedBlue = Color(0xFF4D869C);
  static const Color darkIndigo = Color(0xFF332941);
  static const Color darkDanger = Color(0xFFAD0000);
  static const Color lightDanger = Color(0xFFFFC6C6);
  static const Color darkCharcoal = Color(0xFF2F3F4A);
  static const Color lightGreen = Color(0xFFBFF9B9);
  static const Color darkGreen = Color(0xFF185D0A);

  static const Color neptune50 = Color(0xFFF3F8F7);
  static const Color neptune100 = Color(0xFFDFEEED);
  static const Color neptune200 = Color(0xFFC3DEDD);
  static const Color neptune300 = Color(0xFF99C7C7);
  static const Color neptune400 = Color(0xFF7AB2B2);
  static const Color neptune500 = Color(0xFF4D8C8D);
  static const Color neptune600 = Color(0xFF437477);
  static const Color neptune700 = Color(0xFF3B6063);
  static const Color neptune800 = Color(0xFF365154);
  static const Color neptune900 = Color(0xFF314548);
  static const Color neptune950 = Color(0xFF1D2C2F);

  static ThemeData get themeData {
    return ThemeData(
      primaryColor: desaturatedBlue,
      scaffoldBackgroundColor: veryLightBlue,
      appBarTheme: const AppBarTheme(
        color: desaturatedCyan,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: desaturatedCyan,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      iconTheme: const IconThemeData(
        color: desaturatedCyan,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: desaturatedCyan,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: desaturatedBlue,
        secondary: desaturatedCyan,
        background: veryLightBlue,
        surface: lightAqua,
      ),
    );
  }
}
