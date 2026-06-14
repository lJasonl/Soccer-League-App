import 'package:flutter/material.dart';

import '../../services/league_data_service.dart';
import 'player_details_screen.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() =>
      _PlayersScreenState();
}

class _PlayersScreenState
    extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    final players = LeagueDataService.players;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Players'),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  player.jerseyNumber.toString(),
                ),
              ),
              title: Text(player.fullName),
              subtitle: Text(
                player.registrationStatus,
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PlayerDetailsScreen(
                      player: player,
                    ),
                  ),
                );

                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}