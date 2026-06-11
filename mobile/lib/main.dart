import 'package:flutter/material.dart';

void main() {
  runApp(const SoccerLeagueApp());
}

class SoccerLeagueApp extends StatelessWidget {
  const SoccerLeagueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer League App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Soccer League App'),
        ),
        body: const Center(
          child: Text(
            'Soccer League App Starting...',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}