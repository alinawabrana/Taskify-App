import 'package:flutter/material.dart';
import 'package:taskify/utils/constants/colors.dart';

class ABottomNavigationBarTheme {
  ABottomNavigationBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavigationBarTheme =
      BottomNavigationBarThemeData(
        backgroundColor: AColors.primaryColor,
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
      );

  static BottomNavigationBarThemeData darkBottomNavigationBarTheme =
      BottomNavigationBarThemeData(
        backgroundColor: Colors.blue,
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
      );
}
