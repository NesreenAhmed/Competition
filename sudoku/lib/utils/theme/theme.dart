import 'package:flutter/material.dart';
import 'package:sudoku/utils/theme/custom_themes/appbar_theme.dart';
import 'package:sudoku/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:sudoku/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:sudoku/utils/theme/custom_themes/text_theme.dart';
import 'package:sudoku/utils/theme/custom_themes/bottom_sheet_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.cyanAccent,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      bottomSheetTheme: TBottomSheet.lightBottomSheetTheme,
      outlinedButtonTheme: TOutLinedButtonTheme.lightOutLinedButtonTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.cyanAccent,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TTextTheme.darkTextTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      bottomSheetTheme: TBottomSheet.darkBottomSheetTheme,
      outlinedButtonTheme: TOutLinedButtonTheme.darkOutLinedButtonTheme);

}
