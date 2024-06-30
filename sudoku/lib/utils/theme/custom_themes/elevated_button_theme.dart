import 'package:flutter/material.dart';

class TElevatedButtonTheme{
  TElevatedButtonTheme._();//to avoid creating instances

  static final lightElevatedButtonTheme=ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff2e72b9),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Color(0xff2e72b9)),
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 95),
      textStyle: const TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final darkElevatedButtonTheme=ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(

      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff2e72b9),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Color(0xff2e72b9)),
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 95),
      textStyle: const TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}