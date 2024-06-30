import 'dart:math';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/screens/game_page.dart';
import 'package:audioplayers/audioplayers.dart';

class SudokuChallengeCalendar extends StatefulWidget {
  const SudokuChallengeCalendar({super.key});

  @override
  State<SudokuChallengeCalendar> createState() => _SudokuChallengeCalendarState();
}

class _SudokuChallengeCalendarState extends State<SudokuChallengeCalendar> {
  late final ValueNotifier<List<DateTime>> _selectedDays;
  late final SharedPreferences prefs;
  DateTime _focusedDay = DateTime.now();
  final List<String> _levels = ['Easy', 'Medium', 'Hard'];
  late DateTime _selectedDay;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Set<String> _completedDaysSet = {};

  @override
  void initState() {
    super.initState();
    _selectedDays = ValueNotifier([]);
    _focusedDay = DateTime.now();
    _loadPlayedDays();
    //_initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    super.dispose();
  }

  void _initAudioPlayer() async {
    await _audioPlayer.play(
      AssetSource("audio/asstes_audio_game_sound.mp3"),
      volume: 1.0, // Adjust volume as needed
      // You can also specify other parameters like `position`, `respectSilence`, etc.
    );
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    setState(() {
      _isPlaying = true;
    });
  }

  void _loadPlayedDays() async {
    prefs = await SharedPreferences.getInstance();
    final playedDaysString = prefs.getStringList('playedDays') ?? [];
    final playedDays = playedDaysString.map((day) => DateTime.parse(day)).toList();
    _selectedDays.value = playedDays;

    _completedDaysSet = prefs.getStringList('completedDaysSet')?.toSet() ?? {};
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (_isSameDay(selectedDay, DateTime.now())) {
      if (!_selectedDays.value.contains(selectedDay)) {
        _selectedDays.value.add(selectedDay);
        _selectedDays.notifyListeners();
        await prefs.setStringList('playedDays', _selectedDays.value.map((day) => day.toString()).toList());
        String randomLevel = _getRandomLevel();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SudokuGamePage(
              level: randomLevel,
              onGameCompleted: () => _markDayAsPlayed(selectedDay),
            ),
          ),
        );
      } else {
        // Check for completed game data
        final hasCompletedGame = prefs.getBool('completedGame_${selectedDay.toString()}') ?? false ;
        print('Has completed game: $hasCompletedGame');
        if (hasCompletedGame) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You already completed today\'s challenge!'),
            ),
          );

        } else {
          // No completed game, allow re-entry
          String randomLevel = _getRandomLevel();
          print('Re-entering game for day: $selectedDay');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SudokuGamePage(
                level: randomLevel,
                onGameCompleted: () => _markDayAsPlayed(selectedDay),
              ),
            ),
          );
        }
      }
    } else {
      print(_completedDaysSet);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can only play the game for today!'),
        ),
      );
    }
    setState(() {
      _focusedDay = focusedDay;
    });
  }


  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _markDayAsPlayed(DateTime day)  {
    // Update played days list only if not already marked
    if (!_selectedDays.value.contains(day)) {
      _selectedDays.value.add(day);
      _selectedDays.notifyListeners();
       prefs.setStringList('playedDays', _selectedDays.value.map((day) => day.toString()).toList());
    }
    prefs.setBool('completedGame_${day.toString()}', true);
    _completedDaysSet.add(day.toString());
    prefs.setStringList('completedDaysSet', _completedDaysSet.toList());

  }


  String _getRandomLevel() {
    final random = Random();
    return _levels[random.nextInt(_levels.length)];
  }


  @override
  Widget build(BuildContext context) {
    final DateTime firstDay = DateTime.utc(2020, 1, 1);
    final DateTime lastDay = DateTime.utc(2030, 12, 31);

    if (_focusedDay.isAfter(lastDay)) {
      _focusedDay = lastDay;
    } else if (_focusedDay.isBefore(firstDay)) {
      _focusedDay = firstDay;
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text('Sudoku Challenge')),
      body: ValueListenableBuilder<List<DateTime>>(
        valueListenable: _selectedDays,
        builder: (context, value, _) {
          return TableCalendar(
            focusedDay: _focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            selectedDayPredicate: (day) {
              return _selectedDays.value.contains(day);
            },
            onDaySelected: _onDaySelected,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_completedDaysSet.contains(day.toString())) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                  );
                }
                return null;
              },
            ),
          );
        },
      ),
    );
  }
}


