import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class THelperFunctions {

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context ) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context ) {
    return MediaQuery.of(context).size.width;

  }

  static String getFormattedDte(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

}