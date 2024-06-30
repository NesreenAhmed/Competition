import 'package:flutter/material.dart';
import 'package:sudoku/utils/helper_function.dart';

class SudokuCell extends StatelessWidget {
  final int number;
  final double topBorder;
  final double leftBorder;
  final double rightBorder;
  final double bottomBorder;
  final bool isSelected;
  final bool isInitial;
  final int? selectedNumber;
  final bool isConflict;

  SudokuCell({super.key,
      required this.number,
      required this.isSelected,
      required this.isInitial,
      required this.bottomBorder,
      required this.leftBorder,
      required this.rightBorder,
      required this.topBorder,
      required this.selectedNumber,
      required this.isConflict,});

  @override
  Widget build(BuildContext context) {
    //print("Text color for conflicting cell:${isConflict} ${isSelected}");
    final darkMode = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: isConflict
            ? Colors.red.shade100
             : isSelected && isInitial
                ? Colors.yellow.shade300
                : (selectedNumber != null &&
                        number == selectedNumber &&
                        !isInitial)
                    ? Colors.blue.shade100
                    : darkMode ?Colors.black26:Colors.white,

        border: //Border.all(color: Colors.black),
            Border(
          top: BorderSide(width: topBorder, color: darkMode?Colors.white:Colors.black),
          left: BorderSide(width: leftBorder, color: darkMode?Colors.white:Colors.black),
          right: BorderSide(width: rightBorder, color:darkMode?Colors.white: Colors.black),
          bottom: BorderSide(width: bottomBorder, color: darkMode?Colors.white:Colors.black),
        ),
      ),
      child: Center(
        child: Text(
          number != 0 ? number.toString() : '',
          style: TextStyle(
            fontSize: 20.0,
            color: isConflict ? Colors.red : isInitial ? darkMode?Colors.grey: Colors.black : Colors.blue,

          ),
        ),

      ),
    );

  }
}
