import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../services/game_data_service.dart';

class EditScoreScreen extends StatefulWidget {
  final Game game;

  const EditScoreScreen({
    super.key,
    required this.game,
  });

  @override
  State<EditScoreScreen> createState() =>
      _EditScoreScreenState();
}

class _EditScoreScreenState
    extends State<EditScoreScreen> {
  late final TextEditingController
      _homeScoreController;

  late final TextEditingController
      _awayScoreController;

  @override
  void initState() {
    super.initState();

    _homeScoreController =
        TextEditingController(
      text: widget.game.homeScore.toString(),
    );

    _awayScoreController =
        TextEditingController(
      text: widget.game.awayScore.toString(),
    );
  }

  @override
  void dispose() {
    _homeScoreController.dispose();
    _awayScoreController.dispose();
    super.dispose();
  }

  Future<void> _saveScore() async {
    final updatedGame = Game(
      id: widget.game.id,
      homeTeam: widget.game.homeTeam,
      awayTeam: widget.game.awayTeam,
      gameDate: widget.game.gameDate,
      gameTime: widget.game.gameTime,
      field: widget.game.field,
      homeScore:
          int.tryParse(
            _homeScoreController.text,
          ) ??
          0,
      awayScore:
          int.tryParse(
            _awayScoreController.text,
          ) ??
          0,
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
        title: const Text('Enter Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${widget.game.homeTeam} vs ${widget.game.awayTeam}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller:
                  _homeScoreController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: 'Home Score',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  _awayScoreController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: 'Away Score',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveScore,
                child: const Text(
                  'Save Score',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}