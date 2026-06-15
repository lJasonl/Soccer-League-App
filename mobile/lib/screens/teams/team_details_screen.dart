import 'package:flutter/material.dart';

import '../../models/player.dart';
import '../../models/team.dart';
import '../../services/league_data_service.dart';
import '../../services/player_data_service.dart';
import '../../services/team_data_service.dart';
import '../players/add_player_screen.dart';
import '../players/player_details_screen.dart';
import 'edit_team_screen.dart';

class TeamDetailsScreen extends StatefulWidget {
  final Team team;

  const TeamDetailsScreen({
    super.key,
    required this.team,
  });

  @override
  State<TeamDetailsScreen> createState() =>
      _TeamDetailsScreenState();
}

class _TeamDetailsScreenState
    extends State<TeamDetailsScreen> {
  Future<void> _deleteTeam() async {
    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Team',
          ),
          content: Text(
            'Delete ${widget.team.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child:
                  const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child:
                  const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await TeamDataService.deleteTeam(
        widget.team.id,
      );

      if (!mounted) return;

      Navigator.pop(context);
    }
  }

  Future<void> _deletePlayer(
    Player player,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Remove Player',
          ),
          content: Text(
            'Remove ${player.fullName} from the roster?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child:
                  const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child:
                  const Text('Remove'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await PlayerDataService.deletePlayer(
        player.id,
      );

      setState(() {});
    }
  }

  Color _statusColor(
    String status,
  ) {
    switch (
        status.toLowerCase()) {
      case 'registered':
        return Colors.green;

      case 'pending':
        return Colors.orange;

      case 'unpaid':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final teamPlayers =
        LeagueDataService
            .getPlayersForTeam(
      widget.team.id,
    )..sort(
            (a, b) =>
                a.jerseyNumber.compareTo(
          b.jerseyNumber,
        ),
          );

    final registeredCount =
        teamPlayers.where((p) {
      return p.registrationStatus
              .toLowerCase() ==
          'registered';
    }).length;

    final pendingCount =
        teamPlayers.where((p) {
      return p.registrationStatus
              .toLowerCase() ==
          'pending';
    }).length;

    final unpaidCount =
        teamPlayers.where((p) {
      return p.registrationStatus
              .toLowerCase() ==
          'unpaid';
    }).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.team.name,
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      EditTeamScreen(
                    team: widget.team,
                  ),
                ),
              );

              setState(() {});
            },
          ),
          IconButton(
            icon:
                const Icon(Icons.delete),
            onPressed:
                _deleteTeam,
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddPlayerScreen(
                teamId:
                    widget.team.id,
              ),
            ),
          );

          setState(() {});
        },
        child:
            const Icon(Icons.add),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets
                        .all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      widget.team.name,
                      style:
                          const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Division: ${widget.team.division}',
                    ),
                    Text(
                      'Coach: ${widget.team.coachName}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets
                        .all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      'Roster Summary',
                      style:
                          Theme.of(
                        context,
                      )
                              .textTheme
                              .titleMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Players: ${teamPlayers.length}',
                    ),
                    Text(
                      'Registered: $registeredCount',
                    ),
                    Text(
                      'Pending: $pendingCount',
                    ),
                    Text(
                      'Unpaid: $unpaidCount',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Roster (${teamPlayers.length})',
              style:
                  const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            if (teamPlayers.isEmpty)
              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(
                    24,
                  ),
                  child: Center(
                    child: Text(
                      'No players have been added to this team.',
                    ),
                  ),
                ),
              ),
            ...teamPlayers.map(
              (player) => Card(
                child: ListTile(
                  leading:
                      CircleAvatar(
                    child: Text(
                      player
                          .jerseyNumber
                          .toString(),
                    ),
                  ),
                  title: Text(
                    player.fullName,
                  ),
                  subtitle: Text(
                    player
                        .registrationStatus,
                  ),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Chip(
                        label: Text(
                          player
                              .registrationStatus,
                        ),
                        backgroundColor:
                            _statusColor(
                          player
                              .registrationStatus,
                        ),
                      ),
                      IconButton(
                        icon:
                            const Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          _deletePlayer(
                            player,
                          );
                        },
                      ),
                    ],
                  ),
                  onTap: () async {
                    await Navigator
                        .push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PlayerDetailsScreen(
                          player:
                              player,
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