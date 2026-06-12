import 'package:flutter/material.dart';

import '../../models/player.dart';
import '../../services/league_data_service.dart';
import 'edit_player_screen.dart';

class PlayerDetailsScreen extends StatelessWidget {
  final Player player;

  const PlayerDetailsScreen({
    super.key,
    required this.player,
  });

  Future<void> _deletePlayer(
    BuildContext context,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Player'),
          content: Text(
            'Delete ${player.fullName}?',
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
      LeagueDataService.deletePlayer(player.id);

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.fullName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditPlayerScreen(
                    player: player,
                  ),
                ),
              );

              Navigator.pop(context, true);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deletePlayer(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Jersey Number: #${player.jerseyNumber}',
                    ),
                    Text(
                      'Birth Year: ${player.birthYear}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text(
                  'Parent / Guardian',
                ),
                subtitle: Text(
                  player.parentName,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text(
                  'Parent Phone',
                ),
                subtitle: Text(
                  player.parentPhone,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.badge),
                title: const Text(
                  'Registration Status',
                ),
                subtitle: Text(
                  player.registrationStatus,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}