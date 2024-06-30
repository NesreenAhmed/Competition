import 'package:flutter/material.dart';
import 'package:sudoku/utils/helper_function.dart';
import 'package:sudoku/navigation_menu.dart';

void showQuitDialog(BuildContext context) {
  final darkMode = THelperFunctions.isDarkMode(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Do you want to Quit?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Handle "Yes" selection
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigationMenu()),
                    );
                  },
                  child:  Text('Yes',style: TextStyle(fontSize: 20,color: darkMode ? Colors.white : Colors.black26 ),),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:  Text('No',style: TextStyle(fontSize: 20,color: darkMode ? Colors.white : Colors.black26 )),
                ),
              ],
            ),


          ],
        ),
      );
    },
  );
}
