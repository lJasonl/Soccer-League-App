import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../services/game_data_service.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() =>
      _AddGameScreenState();
}

class _AddGameScreenState
    extends State<AddGameScreen> {
  final _homeTeamController =
      TextEditingController();

  final _awayTeamController =
      TextEditingController();

  final _dateController =
      TextEditingController();

  final _timeController =
      TextEditingController();

  final _fieldController =
      TextEditingController();

  @override
  void dispose() {
    _homeTeamController.dispose();
    _awayTeamController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  void _saveGame() {
    final game = Game(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      homeTeam: _homeTeamController.text,
      awayTeam: _awayTeamController.text,
      gameDate: _dateController.text,
      gameTime: _timeController.text,
      field: _fieldController.text,
      homeScore: 0,
      awayScore: 0,
    );

    GameDataService.addGame(game);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _homeTeamController,
              decoration: const InputDecoration(
                labelText: 'Home Team',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _awayTeamController,
              decoration: const InputDecoration(
                labelText: 'Away Team',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Game Date',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Game Time',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fieldController,
              decoration: const InputDecoration(
                labelText: 'Field',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveGame,
              child: const Text('Save Game'),
            ),
          ],
        ),
      ),
    );
  }
}