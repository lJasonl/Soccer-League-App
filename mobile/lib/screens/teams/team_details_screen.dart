import 'package:flutter/material.dart';

import '../../models/team.dart';
import '../../services/league_data_service.dart';
import '../players/player_details_screen.dart';
import '../players/add_player_screen.dart';

class TeamDetailsScreen extends StatefulWidget {
  final Team team;

  const TeamDetailsScreen({
    super.key,
    required this.team,
  });

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final teamPlayers =
        LeagueDataService.getPlayersForTeam(widget.team.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team.name),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddPlayerScreen(
                teamId: widget.team.id,
              ),
            ),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.team.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Division: ${widget.team.division}'),
                    Text('Coach: ${widget.team.coach}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Players',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            ...teamPlayers.map(
              (player) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      player.jerseyNumber.toString(),
                    ),
                  ),
                  title: Text(player.fullName),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlayerDetailsScreen(
                          player: player,
                        ),
                      ),
                    );

                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}