import 'package:flutter/material.dart';

import '../../services/coach_data_service.dart';
import '../../services/game_data_service.dart';
import '../../services/player_data_service.dart';
import '../../services/referee_data_service.dart';
import '../../services/season_data_service.dart';
import '../../services/team_data_service.dart';
import '../../services/registration_data_service.dart';
import '../../services/scholarship_data_service.dart';
import '../../services/volunteer_data_service.dart';

import '../admin/screen.dart' as admin;
import '../games/games_screen.dart';
import '../payments/screen.dart';
import '../players/players_screen.dart';
import '../registrations/screen.dart';
import '../schedules/schedules_screen.dart';
import '../standings/standings_screen.dart';
import '../teams/teams_screen.dart';
import '../scholarships/scholarship_screen.dart';

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
  static const Color dcsaNavy =
      Color(0xFF0B2A5B);

  @override
  Widget build(
    BuildContext context,
  ) {
    final activeSeason =
        SeasonDataService.seasons
            .where(
              (s) => s.isActive,
            )
            .toList();

    final seasonName =
        activeSeason.isNotEmpty
            ? activeSeason.first.name
            : 'No Active Season';

    final upcomingGames =
        GameDataService.games
            .take(3)
            .toList();

    final volunteerHours =
        VolunteerDataService.entries
            .fold<double>(
      0,
      (sum, entry) =>
          sum +
          entry.hoursWorked,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Darke County Soccer Association',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(
              seasonName,
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(
              'League Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
                color: dcsaNavy,
              ),
            ),

            const SizedBox(
              height: 10,
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
                  width: 10,
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
              height: 8,
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
                  width: 10,
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
              height: 8,
            ),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    'Scholarships',
                    ScholarshipDataService
                        .activeFamilyCount
                        .toString(),
                    Icons
                        .volunteer_activism,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _statCard(
                    'Volunteer Hrs',
                    volunteerHours
                        .toStringAsFixed(
                      0,
                    ),
                    Icons.handshake,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            const Text(
              'League Activity',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
                color: dcsaNavy,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Card(
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons
                            .app_registration,
                      ),
                      title: const Text(
                        'Registrations',
                      ),
                      trailing: Text(
                        RegistrationDataService
                            .registrations
                            .length
                            .toString(),
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(
                        Icons
                            .sports_soccer,
                      ),
                      title: const Text(
                        'Games Scheduled',
                      ),
                      trailing: Text(
                        GameDataService
                            .games.length
                            .toString(),
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(
                        Icons.people,
                      ),
                      title: const Text(
                        'Scholarship Families',
                      ),
                      trailing: Text(
                        ScholarshipDataService
                            .activeFamilyCount
                            .toString(),
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            const Text(
              'Upcoming Games',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
                color: dcsaNavy,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            if (upcomingGames.isEmpty)
              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(
                    20,
                  ),
                  child: Text(
                    'No scheduled games.',
                  ),
                ),
              ),            ...upcomingGames.map(
              (game) => Card(
                elevation: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    20,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        '${game.homeTeam} vs ${game.awayTeam}',
                        style:
                            const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      Text(
                        '📅 ${game.gameDate}',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '⏰ ${game.gameTime}',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '📍 ${game.field}',
                      ),
                      if (game
                          .refereeName
                          .isNotEmpty)
                        Padding(
                          padding:
                              const EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(
                            '⚖ Referee: ${game.refereeName}',
                          ),
                        ),
                    ],
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
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
                color: dcsaNavy,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
              children: [
                _menu(
                  context,
                  'Teams',
                  Icons.groups,
                  const TeamsScreen(),
                ),
                _menu(
                  context,
                  'Players',
                  Icons.person,
                  const PlayersScreen(),
                ),
                _menu(
                  context,
                  'Schedules',
                  Icons.calendar_month,
                  const SchedulesScreen(),
                ),
                _menu(
                  context,
                  'Games',
                  Icons.sports_soccer,
                  const GamesScreen(),
                ),
                _menu(
                  context,
                  'Standings',
                  Icons.emoji_events,
                  const StandingsScreen(),
                ),
                _menu(
                  context,
                  'Registrations',
                  Icons.app_registration,
                  const RegistrationsScreen(),
                ),
                _menu(
                  context,
                  'Payments',
                  Icons.payment,
                  const PaymentsScreen(),
                ),
                _menu(
                  context,
                  'Scholarships',
                  Icons.volunteer_activism,
                  const ScholarshipScreen(),
                ),
                _menu(
                  context,
                  'Admin',
                  Icons.admin_panel_settings,
                  const admin.Screen(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(
    String seasonName,
  ) {
    return Container(
      width: double.infinity,
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
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.all(
              10,
            ),
            decoration:
                const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/dcsa_logo.png',
              height: 100,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                const Text(
                  'Darke County\nSoccer Association',
                  style: TextStyle(
                    color:
                        Colors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    seasonName,
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
        ],
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding:
            const EdgeInsets.all(
          12,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor:
                  dcsaNavy,
              child: Icon(
                icon,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
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

  Widget _menu(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => screen,
          ),
        );

        if (mounted) {
          setState(() {});
        }
      },
      borderRadius:
          BorderRadius.circular(
        16,
      ),
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor:
                  dcsaNavy,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              textAlign:
                  TextAlign.center,
              style:
                  const TextStyle(
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