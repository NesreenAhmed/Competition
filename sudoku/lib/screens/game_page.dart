import 'package:flutter/material.dart';
import 'package:sudoku/common/widget/custom_shapes/primary_header_container.dart';
import 'package:sudoku/data/play_buttons.dart';
import 'package:sudoku/data/sudoku_puzzle.dart';
import 'package:sudoku/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:sudoku/data/buttons.dart';
import 'dart:async';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sudoku/screens/success_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sudoku/data/quit_dialog.dart';
import 'package:sudoku/data/sudoku_grid.dart';


class SudokuGamePage extends StatefulWidget {
  const SudokuGamePage({super.key,
    required this.level,
    this.onGameCompleted,
    this.selectedDay
  });
  final String level;
  final VoidCallback? onGameCompleted;
  final DateTime? selectedDay;

  @override
  State<SudokuGamePage> createState() => _SudokuGamePageState();
}

class _SudokuGamePageState extends State<SudokuGamePage> {
  int? selectedNumber;
  late List<List<int>> sudokuPuzzle;
  late List<List<int>> initialPuzzle;
  late List<List<bool>> initialCells;
  late List<List<bool>> conflictCells;
  List<Map<String, dynamic>> moveHistory = [];

  Timer? _timer;
  int _elapsedSeconds = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  final int maxHints = 3;
  int remainingHints = 3;


  @override
  void initState() {
    super.initState();
    //FlutterNativeSplash.remove();
    _initializeNewPuzzle();
    _startTimer();
    //_initAudioPlayer();
  }


  void _initAudioPlayer() async {
    await _audioPlayer.play(
      AssetSource("audio/asstes_audio_game_sound.mp3"),
      volume: 2.0, // Adjust volume as needed
      // You can also specify other parameters like `position`, `respectSilence`, etc.
    );
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    setState(() {
      _isPlaying = true;
    });
  }

  void conflictSound() async {
    await _audioPlayer.play(AssetSource('audio/assets_audio_wrong_tip.wav'));
  }

  void toggleSound() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.play( AssetSource('audio/asstes_audio_game_sound.mp3'));
      //resume();
      //play( AssetSource('audio/asstes_audio_game_sound.mp3'));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _elapsedSeconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _restartTimer() {
    _stopTimer();
    _startTimer();
  }

  void _initializeNewPuzzle() {
    sudokuPuzzle = generateNewSudokuPuzzle(widget.level);
    initialCells = List.generate(9, (i) => List.generate(9, (j) => sudokuPuzzle[i][j] != 0));
    initialPuzzle = List.generate(9, (i) => List.from(sudokuPuzzle[i]));
    conflictCells = List.generate(9, (_) => List.generate(9, (_) => false));


  }

  void onNumberSelected(int? number) {
    setState(() {
      if (selectedNumber == number) {
        selectedNumber = null;
      } else {
        selectedNumber = number;
      }
    });
  }

  void onCellTapped(int row, int col) {
    setState(() {
      if (!initialCells[row][col]) {
        if (selectedNumber != null) {
          moveHistory.add({
            'row': row,
            'col': col,
            'previousValue': sudokuPuzzle[row][col],
          });
          // Check for conflicts in the same row and column
          bool conflict = false;
          for (int i = 0; i < 9; i++) {
            if (sudokuPuzzle[row][i] == selectedNumber || sudokuPuzzle[i][col] == selectedNumber) {
              conflict = true;
              break;
            }
          }
          if (conflict) {
            conflictSound();
            conflictCells[row][col] = true;
            sudokuPuzzle[row][col] = selectedNumber!;
          } else {
            sudokuPuzzle[row][col] = selectedNumber!;
            conflictCells[row][col] = false;

          }
        } else {
          // Clear the cell if it's not an initial cell
          if (!initialCells[row][col]) {
            moveHistory.add({
              'row': row,
              'col': col,
              'previousValue': sudokuPuzzle[row][col],
            });
            sudokuPuzzle[row][col] = 0;
            conflictCells[row][col] = false;
          }
        }
        if (isPuzzleSolved()) {
          _stopTimer();
          if (widget.onGameCompleted != null) {
            widget.onGameCompleted!();
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessScreen(elapsedSeconds: _elapsedSeconds),
            ),
          );
        }
      }
    });
  }

  void undoLastMove() {
    setState(() {
      if (moveHistory.isNotEmpty) {
        Map<String, dynamic> lastMove = moveHistory.removeLast();
        int row = lastMove['row'];
        int col = lastMove['col'];
        int previousValue = lastMove['previousValue'];
        sudokuPuzzle[row][col] = previousValue;
        conflictCells[row][col] = false;
      }
      moveHistory.clear();
    });
  }

  void restartGame() {
    setState(() {
      moveHistory.clear();
      sudokuPuzzle = List.generate(9, (i) => List.from(initialPuzzle[i]));// Reset to initial puzzle state
      for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
          conflictCells[row][col] = false;
          }
        }
      remainingHints=3;
      _restartTimer();
    });
  }

  void useHint() {
    if (remainingHints > 0) {
      setState(() {
        remainingHints--;
        List<List<int>> solvedPuzzle = List.generate(9, (i) => List.from(sudokuPuzzle[i]));
        solveSudoku(solvedPuzzle);

        // Find an empty cell in the current puzzle and reveal its value
        bool hintUsed = false;
        for (int row = 0; row < 9 && !hintUsed; row++) {
          for (int col = 0; col < 9 && !hintUsed; col++) {
            if (sudokuPuzzle[row][col] == 0) {
              sudokuPuzzle[row][col] = solvedPuzzle[row][col];
              hintUsed = true;
            }
          }
        }
        // Update UI or show message if no empty cells were found
        if (!hintUsed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No empty cells left to reveal!')),
          );
        }

        // Update remaining hints
        if (remainingHints == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No more hints available!')),
          );
        }
      });
    }
  }

  bool isPuzzleSolved() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (sudokuPuzzle[row][col] == 0 || conflictCells[row][col]) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
             TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    AppBar(backgroundColor:const Color(0XFF407aff)
                      ,title:const Text('sudoku Game',style: TextStyle(color: Colors.white),),
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(onPressed:toggleSound
                            ,icon:Icon(_isPlaying ?Icons.music_note_sharp:Icons.music_off)
                        ),
                        IconButton(onPressed:()=> showQuitDialog(context)
                            ,icon:const Icon(Icons.dehaze_outlined)
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItem,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Padding(padding: const EdgeInsets.only(left:18),
                          child:Text('Level: ${widget.level}',style: const TextStyle(fontSize: 18, color: Color(0XFFd0e0f8))) ,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: Text('Hints: $remainingHints',
                            style: const TextStyle(fontSize: 18, color: Color(0XFFd0e0f8)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child:  Text(
                            _formatTime(_elapsedSeconds),
                            style: const TextStyle(fontSize: 18, color: Color(0XFFd0e0f8)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItem,),
                    TButtons(onNumberSelected: onNumberSelected,undoLastMove: undoLastMove,restartGame: restartGame,hint: useHint,),
                    const SizedBox(height: TSizes.spaceBtwSections,),
                  ],
            ),
            ),
            SizedBox(
              height: 500.0,
              child: SudokuGrid(
                sudokuPuzzle: sudokuPuzzle,
                selectedNumber: selectedNumber,
                onCellTapped: onCellTapped,
                initialCells: initialCells,
                conflictCells: conflictCells,
              ),
            ),
            SizedBox(
              height: 300.0,
              child: PlayButtons(onNumberSelected: onNumberSelected),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatTime(int elapsedSeconds) {
  final minutes = elapsedSeconds ~/ 60;
  final seconds = elapsedSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
