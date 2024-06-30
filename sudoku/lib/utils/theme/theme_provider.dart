import 'package:flutter/material.dart';
import 'package:sudoku/utils/theme/theme_notifier.dart';

class ThemeProvider extends InheritedNotifier<ThemeNotifier> {
  const ThemeProvider({
    Key? key,
    required ThemeNotifier notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static ThemeNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!.notifier!;
  }
}