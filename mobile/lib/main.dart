import 'package:flutter/material.dart';

void main() {
  runApp(const SoccerLeagueApp());
}

class SoccerLeagueApp extends StatelessWidget {
  const SoccerLeagueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer League',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Soccer League'),
        ),
        body: const Center(
          child: Text('App Setup Complete'),
        ),
      ),
    );
  }
}
