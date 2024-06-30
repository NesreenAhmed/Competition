import 'package:flutter/material.dart';
import 'package:sudoku/common/widget/appbar/appbar.dart';
import 'package:audioplayers/audioplayers.dart';

class THomeAppBar extends StatefulWidget {
  const THomeAppBar({super.key});

  @override
  State<THomeAppBar> createState() => _THomeAppBarState();
}

class _THomeAppBarState extends State<THomeAppBar> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
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

  @override
  void dispose() {
    _audioPlayer.dispose();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    super.dispose();
  }

  void _toggleSound() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.play( AssetSource('audio/asstes_audio_game_sound.mp3')
      );
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sudoku',
                style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.grey.shade400),
              ),
              Text(
                'Welcome Back!!',
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(width: 170),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: _toggleSound,
              icon: Icon(_isPlaying ?Icons.music_note_sharp:Icons.music_off),
            ),
          ),
        ],
      ),
    );
  }
}
