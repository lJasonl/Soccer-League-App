import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../services/game_data_service.dart';

class EditGameScreen extends StatefulWidget {
  final Game game;

  const EditGameScreen({
    super.key,
    required this.game,
  });

  @override
  State<EditGameScreen> createState() =>
      _EditGameScreenState();
}

class _EditGameScreenState
    extends State<EditGameScreen> {
  late final TextEditingController
      _homeTeamController;

  late final TextEditingController
      _awayTeamController;

  late final TextEditingController
      _dateController;

  late final TextEditingController
      _timeController;

  late final TextEditingController
      _fieldController;

  @override
  void initState() {
    super.initState();

    _homeTeamController =
        TextEditingController(
      text: widget.game.homeTeam,
    );

    _awayTeamController =
        TextEditingController(
      text: widget.game.awayTeam,
    );

    _dateController =
        TextEditingController(
      text: widget.game.gameDate,
    );

    _timeController =
        TextEditingController(
      text: widget.game.gameTime,
    );

    _fieldController =
        TextEditingController(
      text: widget.game.field,
    );
  }

  @override
  void dispose() {
    _homeTeamController.dispose();
    _awayTeamController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  Future<void> _saveGame() async {
    final updatedGame = Game(
      id: widget.game.id,
      homeTeam: _homeTeamController.text,
      awayTeam: _awayTeamController.text,
      gameDate: _dateController.text,
      gameTime: _timeController.text,
      field: _fieldController.text,
      homeScore: widget.game.homeScore,
      awayScore: widget.game.awayScore,
    );

    await GameDataService.updateGame(
      updatedGame,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Game'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:
                  _homeTeamController,
              decoration:
                  const InputDecoration(
                labelText: 'Home Team',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  _awayTeamController,
              decoration:
                  const InputDecoration(
                labelText: 'Away Team',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _dateController,
              decoration:
                  const InputDecoration(
                labelText: 'Game Date',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _timeController,
              decoration:
                  const InputDecoration(
                labelText: 'Game Time',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  _fieldController,
              decoration:
                  const InputDecoration(
                labelText: 'Field',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveGame,
                child: const Text(
                  'Save Changes',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}