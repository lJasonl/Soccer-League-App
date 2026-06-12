import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../services/game_data_service.dart';

class GameResultScreen extends StatefulWidget {
  final Game game;

  const GameResultScreen({
    super.key,
    required this.game,
  });

  @override
  State<GameResultScreen> createState() =>
      _GameResultScreenState();
}

class _GameResultScreenState
    extends State<GameResultScreen> {
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

  void _saveResult() {
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

    GameDataService.updateGame(
      updatedGame,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${widget.game.homeTeam} vs ${widget.game.awayTeam}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _homeScoreController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  InputDecoration(
                labelText:
                    '${widget.game.homeTeam} Score',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _awayScoreController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  InputDecoration(
                labelText:
                    '${widget.game.awayTeam} Score',
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveResult,
                child:
                    const Text('Save Result'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}