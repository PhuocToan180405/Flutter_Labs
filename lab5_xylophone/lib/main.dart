import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: XylophonePage(),
    );
  }
}

class XylophonePage extends StatefulWidget {
  const XylophonePage({super.key});

  @override
  State<XylophonePage> createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _player.setPlayerMode(PlayerMode.lowLatency);
    _player.setVolume(0.85);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void playSound(int soundNumber) {
    _player.play(
      AssetSource('note$soundNumber.wav'),
      mode: PlayerMode.lowLatency,
      volume: 0.85,
    );
  }

  Widget buildKey({required Color color, required int soundNumber}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white24,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () => playSound(soundNumber),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildKey(color: const Color(0xFFF44336), soundNumber: 1),
            buildKey(color: const Color(0xFFFF9800), soundNumber: 2),
            buildKey(color: const Color(0xFFFFEB3B), soundNumber: 3),
            buildKey(color: const Color(0xFF4CAF50), soundNumber: 4),
            buildKey(color: const Color(0xFF009688), soundNumber: 5),
            buildKey(color: const Color(0xFF2196F3), soundNumber: 6),
            buildKey(color: const Color(0xFF9C27B0), soundNumber: 7),
          ],
        ),
      ),
    );
  }
}
