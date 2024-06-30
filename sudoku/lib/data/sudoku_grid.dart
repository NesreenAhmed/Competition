import 'package:flutter/material.dart';
import 'package:sudoku/data/sudoku_cell.dart';
import 'package:flutter/cupertino.dart';


class SudokuGrid extends StatelessWidget {
  final int? selectedNumber;
  final List<List<int>> sudokuPuzzle;
  final Function(int, int) onCellTapped;
  final List<List<bool>> initialCells;
  final List<List<bool>> conflictCells;


  const SudokuGrid({
    super.key,
    required this.selectedNumber,
    required this.sudokuPuzzle,
    required this.onCellTapped,
    required this.initialCells,
    required this.conflictCells,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: 81,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          int row = index ~/ 9;
          int col = index % 9;
          return GestureDetector(
            onTap: () {
              onCellTapped(row, col);
            },
            child: SudokuCell(
              isSelected: sudokuPuzzle[row][col] == selectedNumber && initialCells[row][col],
              number: sudokuPuzzle[row][col],
              isInitial: initialCells[row][col],
              isConflict: conflictCells[row][col],
              topBorder: row % 3 == 0 ? 1.5 : 0.5,
              leftBorder: col % 3 == 0 ? 1.5 : 0.5,
              rightBorder: col % 3 == 2 ? 1.5 : 0.5,
              bottomBorder: row % 3 == 2 ? 1.5 : 0.5,
              selectedNumber: selectedNumber,
            ),
          );
        },
      ),
    );
  }
}
