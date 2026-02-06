import 'package:flutter/material.dart';
import 'package:taskify/utils/theme/custom_themes/bottom_navigation_theme.dart';

import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

// For all custom widgets and classes we will use T as a prefix so that whenever we need to call a custom widget or class we just have to write T and list will be shown

class TAppTheme {
  TAppTheme._(); // This constructor has now become private. Therefore no one can access it from outside the theme.dart file.
  // This is done so that we accidentally should not call the constructor of the class everytime we create an instance of it.

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    // This is very Important as this will tell the flutter that either the mode is light or dark.
    primaryColor: Color.fromRGBO(93, 144, 199, 1),
    textTheme: ATextTheme.lightTextTheme,
    chipTheme: AChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AAppBarTheme.lightAppBarTheme,
    checkboxTheme: ACheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: ABottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: ATextFieldTheme.lightInputDecorationTheme,
    bottomNavigationBarTheme:
        ABottomNavigationBarTheme.lightBottomNavigationBarTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    // This is very Important as this will tell the flutter that either the mode is light or dark.
    primaryColor: Color.fromRGBO(93, 144, 199, 1),
    textTheme: ATextTheme.darkTextTheme,
    chipTheme: AChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AAppBarTheme.darkAppBarTheme,
    checkboxTheme: ACheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: ABottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: ATextFieldTheme.darkInputDecorationTheme,
    bottomNavigationBarTheme:
        ABottomNavigationBarTheme.darkBottomNavigationBarTheme,
  );
}
