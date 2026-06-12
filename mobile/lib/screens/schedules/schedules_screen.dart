import 'package:flutter/material.dart';

import '../../services/game_data_service.dart';
import 'add_game_screen.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() =>
      _SchedulesScreenState();
}

class _SchedulesScreenState
    extends State<SchedulesScreen> {
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
              leading: const Icon(
                Icons.sports_soccer,
              ),
              title: Text(
                '${game.homeTeam} vs ${game.awayTeam}',
              ),
              subtitle: Text(
                '${game.gameDate} • ${game.gameTime}\n${game.field}',
              ),
            ),
          );
        },
      ),
    );
  }
}