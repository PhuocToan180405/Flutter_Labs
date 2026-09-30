import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic 8 Ball - Lab 4',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9C27B0),
        ),
      ),
      home: const BallPage(),
    );
  }
}

class BallPage extends StatefulWidget {
  const BallPage({super.key});

  @override
  State<BallPage> createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  int ballNumber = 1;

  final Random _random = Random();

  void _askQuestion() {
    setState(() {
      ballNumber = _random.nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCE93D8),
        elevation: 2.0,
        centerTitle: false,
        title: const Text(
          'Ask Me Anything',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _askQuestion,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            constraints: const BoxConstraints(
              maxWidth: 320,
              maxHeight: 320,
            ),
            child: Image.asset(
              'assets/ball$ballNumber.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
