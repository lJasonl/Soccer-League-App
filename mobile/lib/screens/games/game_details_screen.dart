import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../services/game_data_service.dart';
import 'edit_game_screen.dart';
import 'edit_score_screen.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;

  const GameDetailsScreen({
    super.key,
    required this.game,
  });

  @override
  State<GameDetailsScreen> createState() =>
      _GameDetailsScreenState();
}

class _GameDetailsScreenState
    extends State<GameDetailsScreen> {
  late Game game;

  @override
  void initState() {
    super.initState();
    game = widget.game;
  }

  Future<void> _deleteGame() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Game'),
          content: Text(
            'Delete ${game.homeTeam} vs ${game.awayTeam}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await GameDataService.deleteGame(
        game.id,
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    }
  }

  Future<void> _editGame() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditGameScreen(
          game: game,
        ),
      ),
    );

    final updatedGame =
        GameDataService.games.firstWhere(
      (g) => g.id == game.id,
      orElse: () => game,
    );

    setState(() {
      game = updatedGame;
    });
  }

  Future<void> _editScore() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditScoreScreen(
          game: game,
        ),
      ),
    );

    final updatedGame =
        GameDataService.games.firstWhere(
      (g) => g.id == game.id,
      orElse: () => game,
    );

    setState(() {
      game = updatedGame;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.scoreboard),
            onPressed: _editScore,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editGame,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteGame,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  '${game.homeTeam} vs ${game.awayTeam}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Date: ${game.gameDate}',
                ),

                Text(
                  'Time: ${game.gameTime}',
                ),

                Text(
                  'Field: ${game.field}',
                ),

                const SizedBox(height: 24),

                const Text(
                  'Final Score',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '${game.homeScore} - ${game.awayScore}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}