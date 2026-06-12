import 'package:flutter/material.dart';

import '../../services/game_data_service.dart';
import 'add_game_screen.dart';
import 'edit_game_screen.dart';
import 'game_result_screen.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() =>
      _SchedulesScreenState();
}

class _SchedulesScreenState
    extends State<SchedulesScreen> {
  Future<void> _deleteGame(
    String gameId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Game'),
          content: const Text(
            'Are you sure you want to delete this game?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      GameDataService.deleteGame(
        gameId,
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final games = GameDataService.games;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddGameScreen(),
            ),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        GameResultScreen(
                      game: game,
                    ),
                  ),
                );

                setState(() {});
              },
              leading: const Icon(
                Icons.sports_soccer,
              ),
              title: Text(
                '${game.homeTeam} vs ${game.awayTeam}',
              ),
              subtitle: Text(
                '${game.gameDate} • ${game.gameTime}\n'
                '${game.field}\n'
                'Score: ${game.homeScore} - ${game.awayScore}',
              ),
              trailing: Row(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EditGameScreen(
                            game: game,
                          ),
                        ),
                      );

                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      _deleteGame(
                        game.id,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}