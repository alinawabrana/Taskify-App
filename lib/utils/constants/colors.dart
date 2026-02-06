import 'package:flutter/material.dart';

class AColors {
  AColors._();

  // App Basic Colors
  static const Color primaryColor = Color(0xFF1D2733);
  static const Color secondaryColor = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFB0C7FF);

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
  );

  static const Gradient linearGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1D2733), Color(0xFF3B4A5A)],
  );

  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xff6c757d);
  static const Color textWhite = Colors.white;

  // Background Colors
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container Colors
  static const Color lightContainer = Color(0xfff6f6f6);
  static Color darkContainer = Colors.white.withOpacity(0.1);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF4B68FF);
  static const Color buttonSecondary = Color(0xff6c757d);
  static const Color buttonDisabled = Color(0xffc4c4c4);

  // Border Colors
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondary = Color(0xffe6e6e6);

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xfff57c00);
  static const Color info = Color(0xff1976d2);

  // Neutral Shades
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xFF4f4f4f);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);
}
