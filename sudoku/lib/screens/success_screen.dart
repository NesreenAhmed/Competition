import 'package:flutter/material.dart';
import 'package:sudoku/data/level_dialog.dart';
import 'package:sudoku/navigation_menu.dart';
import 'package:sudoku/utils/constants/sizes.dart';
import 'package:audioplayers/audioplayers.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key, this.elapsedSeconds});
  final int? elapsedSeconds;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }
  void _initAudioPlayer() async {
    await _audioPlayer.play(
      AssetSource("audio/asstes_audio_victory.wav"),
      volume: 2.0,
    );
    setState(() {
      _isPlaying = true;
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _toggleSound() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.play( AssetSource('audio/asstes_audio_victory.wav')
      );// Ensure the sound file is added to your assets folder
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  String _formatTime(int elapsedSeconds) {
    final minutes = elapsedSeconds ~/ 60;
    final seconds = elapsedSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffcbf1fc),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:const Color(0xffcbf1fc),
            ),
            child: IconButton(
              onPressed: _toggleSound,
              icon: Icon(_isPlaying ?Icons.music_note_sharp:Icons.music_off,color: Colors.black,),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xffcbf1fc),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Completed in ${_formatTime(widget.elapsedSeconds ?? 0)} minutes!!',
                style: const TextStyle(
                  color: Color(0xff5c007a),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
            ),
            const Image(image: AssetImage("assets/images/welcome_image/Designer (77).png")),
            Padding(
              padding: const EdgeInsets.only(
                bottom: TSizes.spaceBtwItem,
                left: TSizes.spaceBtwItem,
              ),
              child: ElevatedButton(
                onPressed: () => showLevelDialog(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 38),
                ),
                child: const Text(' Start new game '),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: TSizes.spaceBtwItem,
                left: TSizes.spaceBtwItem,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationMenu(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                ),
                child: const Text(' Back to main menu '),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
