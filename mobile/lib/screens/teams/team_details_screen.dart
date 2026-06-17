import 'package:flutter/material.dart';

import '../../models/player.dart';
import '../../models/team.dart';
import '../../services/league_data_service.dart';
import '../../services/player_data_service.dart';
import '../../services/team_data_service.dart';
import '../players/add_player_screen.dart';
import '../players/player_details_screen.dart';
import 'edit_team_screen.dart';
import '../../services/session_service.dart';

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
  static const Color dcsaNavy =
      Color(0xFF0B2A5B);

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
            'Remove ${player.fullName} from roster?',
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
    final role =
    SessionService
        .getCurrentUser()
        ?.role ??
    'Parent';
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
  if (role == 'Admin' ||
      role == 'Coach')
    IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditTeamScreen(
              team: widget.team,
            ),
          ),
        );

        setState(() {});
      },
    ),

  if (role == 'Admin' ||
      role == 'Coach')
    IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        _deleteTeam();
      },
    ),
],
      ),
    floatingActionButton:
    (role == 'Admin' ||
            role == 'Coach')
        ? FloatingActionButton.extended(
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
            icon: const Icon(Icons.person_add),
            label: const Text('Add Player'),
          )
        : null,
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          Container(
            padding:
                const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              color: dcsaNavy,
              borderRadius:
                  BorderRadius.circular(
                24,
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundColor:
                      Colors.white,
                  child: Icon(
                    Icons.groups,
                    size: 40,
                    color: dcsaNavy,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.team.name,
                  textAlign:
                      TextAlign.center,
                  style:
                      const TextStyle(
                    color:
                        Colors.white,
                    fontSize: 26,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.team.division,
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white24,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    'Coach: ${widget.team.coachName}',
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _summaryCard(
                  'Players',
                  teamPlayers.length
                      .toString(),
                  Icons.people,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _summaryCard(
                  'Registered',
                  registeredCount
                      .toString(),
                  Icons.check_circle,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _summaryCard(
                  'Pending',
                  pendingCount
                      .toString(),
                  Icons.schedule,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _summaryCard(
                  'Unpaid',
                  unpaidCount
                      .toString(),
                  Icons.warning,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            'Team Roster (${teamPlayers.length})',
            style:
                const TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (teamPlayers.isEmpty)
            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(
                  24,
                ),
                child: Center(
                  child: Text(
                    'No players on roster.',
                  ),
                ),
              ),
            ),

          ...teamPlayers.map(
            (player) => Card(
              elevation: 2,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading:
                    CircleAvatar(
                  backgroundColor:
                      dcsaNavy,
                  child: Text(
                    player
                        .jerseyNumber
                        .toString(),
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  player.fullName,
                ),
                subtitle: Padding(
                  padding:
                      const EdgeInsets.only(
                    top: 4,
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          _statusColor(
                        player
                            .registrationStatus,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Text(
                      player
                          .registrationStatus,
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                trailing:
    (role == 'Admin' ||
            role == 'Coach')
        ? IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              _deletePlayer(
                player,
              );
            },
          )
        : null,
                onTap: () async {
                  await Navigator.push(
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
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(
          12,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: dcsaNavy,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              title,
              style:
                  const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}