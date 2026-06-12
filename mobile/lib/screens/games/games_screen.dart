import 'package:flutter/material.dart';

import '../../services/game_data_service.dart';
import 'add_game_screen.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    final games = GameDataService.games;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddGameScreen(),
            ),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: games.isEmpty
          ? const Center(
              child: Text(
                'No games scheduled.',
              ),
            )
          : ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      '${game.homeTeam} vs ${game.awayTeam}',
                    ),
                    subtitle: Text(
                      '${game.gameDate} • ${game.gameTime}\nField: ${game.field}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}