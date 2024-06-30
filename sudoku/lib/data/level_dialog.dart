import 'package:flutter/material.dart';
import 'package:sudoku/screens/game_page.dart';

void showLevelDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('Easy'),
              onTap: () {
                // Handle level selection
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const SudokuGamePage(level: 'Easy')),
                );
              },
            ),
            ListTile(
              title: const Text('Medium'),
              onTap: () {
                // Handle level selection
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const SudokuGamePage(level: 'Medium')),
                );
              },
            ),
            ListTile(
              title: const Text('Hard'),
              onTap: () {
                // Handle level selection
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const SudokuGamePage(level: 'Hard')),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}