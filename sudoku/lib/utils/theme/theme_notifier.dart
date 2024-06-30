import 'package:flutter/material.dart';
import 'package:sudoku/utils/helper_function.dart';

class ThemeNotifier extends ChangeNotifier {
  //final darkMode = THelperFunctions.isDarkMode(context);
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}