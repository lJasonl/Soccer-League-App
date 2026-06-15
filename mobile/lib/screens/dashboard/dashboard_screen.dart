import 'package:flutter/material.dart';

import '../../services/coach_data_service.dart';
import '../../services/game_data_service.dart';
import '../../services/player_data_service.dart';
import '../../services/referee_data_service.dart';
import '../../services/season_data_service.dart';
import '../../services/team_data_service.dart';

import '../admin/screen.dart' as admin;
import '../games/games_screen.dart';
import '../payments/screen.dart';
import '../players/players_screen.dart';
import '../registrations/screen.dart';
import '../schedules/schedules_screen.dart';
import '../standings/standings_screen.dart';
import '../teams/teams_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final activeSeason =
        SeasonDataService.seasons
            .where(
              (season) =>
                  season.isActive,
            )
            .toList();

    final seasonName =
        activeSeason.isNotEmpty
            ? activeSeason.first.name
            : 'No Active Season';

    final upcomingGames =
        GameDataService.games.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Darke County Soccer Association',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    const Text(
                      'Current Season',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      seasonName,
                      style:
                          const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    'Teams',
                    TeamDataService
                        .teams.length
                        .toString(),
                    Icons.groups,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: _statCard(
                    'Players',
                    PlayerDataService
                        .players.length
                        .toString(),
                    Icons.person,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    'Coaches',
                    CoachDataService
                        .coaches.length
                        .toString(),
                    Icons.sports,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: _statCard(
                    'Referees',
                    RefereeDataService
                        .referees.length
                        .toString(),
                    Icons.gavel,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            const Text(
              'Upcoming Games',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            if (upcomingGames.isEmpty)
              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(16),
                  child: Text(
                    'No scheduled games.',
                  ),
                ),
              ),

            ...upcomingGames.map(
              (game) => Card(
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
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            const Text(
              'League Menu',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _menuCard(
                  context,
                  'Teams',
                  Icons.groups,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const TeamsScreen(),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                _menuCard(
                  context,
                  'Players',
                  Icons.person,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PlayersScreen(),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                _menuCard(
                  context,
                  'Schedules',
                  Icons.calendar_month,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SchedulesScreen(),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                _menuCard(
                  context,
                  'Games',
                  Icons.sports_soccer,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const GamesScreen(),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                _menuCard(
                  context,
                  'Standings',
                  Icons.emoji_events,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const StandingsScreen(),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                _menuCard(
                  context,
                  'Registrations',
                  Icons.app_registration,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const RegistrationsScreen(),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                _menuCard(
                  context,
                  'Payments',
                  Icons.payment,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PaymentsScreen(),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                _menuCard(
                  context,
                  'Admin',
                  Icons.admin_panel_settings,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const admin.Screen(),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style:
                  const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}