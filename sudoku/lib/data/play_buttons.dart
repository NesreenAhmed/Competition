import 'package:flutter/material.dart';
import 'package:sudoku/utils/helper_function.dart';

class PlayButtons extends StatelessWidget {
  final Function(int?) onNumberSelected;
  PlayButtons({super.key,required this.onNumberSelected});
  final List<int> sudokuButtons = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(5),
      child: Wrap(
        spacing: 35.0,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        children: sudokuButtons.map((number) {
            return GestureDetector(
              onTap: () {
                onNumberSelected(number);
                // Handle number button tap
              },
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: darkMode?const Color(0XFF1f2229):const Color(0XFFe6edff),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  number.toString(),
                  style:  TextStyle(fontSize: 20,color: darkMode? Colors.white: Colors.black),
                ),
              ),
            );
          }).toList(),

      ),
    );
  }
}
