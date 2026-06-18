import 'package:flutter/material.dart';

import '../../services/league_data_service.dart';
import '../../services/team_data_service.dart';
import '../../services/session_service.dart';
import 'add_team_screen.dart';
import 'team_details_screen.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() =>
      _TeamsScreenState();
}

class _TeamsScreenState
    extends State<TeamsScreen> {
  static const Color dcsaNavy =
      Color(0xFF0B2A5B);

  @override
void initState() {
  super.initState();
  _loadData();
}

Future<void> _loadData() async {
  await TeamDataService.loadTeams();

  if (mounted) {
    setState(() {});
  }
}
@override
  Widget build(BuildContext context) {
    final currentUser =
        SessionService.getCurrentUser();

    final role =
        currentUser?.role ??
            'Parent';

    final teams =
        role == 'Coach'
            ? TeamDataService.teams
                .where(
                  (team) =>
                      team.coachId ==
                      currentUser?.id,
                )
                .toList()
            : TeamDataService.teams;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teams',
        ),
      ),
      floatingActionButton:
          role == 'Admin'
              ? FloatingActionButton.extended(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const AddTeamScreen(),
                      ),
                    );

                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                    'Add Team',
                  ),
                )
              : null,
      body: teams.isEmpty
          ? const Center(
              child: Text(
                'No teams have been created.',
              ),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              itemCount:
                  teams.length,
              itemBuilder:
                  (context, index) {
                final team =
                    teams[index];

                final playerCount =
                    LeagueDataService
                        .getPlayersForTeam(
                  team.id,
                ).length;

                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                    onTap: () async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => TeamDetailsScreen(
        team: team,
      ),
    ),
  );

  await TeamDataService.loadTeams();

  if (mounted) {
    setState(() {});
  }
},
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
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets
                                        .all(
                                  10,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color:
                                      dcsaNavy,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    10,
                                  ),
                                ),
                                child:
                                    const Icon(
                                  Icons.groups,
                                  color:
                                      Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Text(
                                  team.name,
                                  style:
                                      const TextStyle(
                                    fontSize:
                                        20,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons
                                    .chevron_right,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons
                                    .emoji_events,
                                size: 18,
                                color:
                                    dcsaNavy,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                team.division,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.sports,
                                size: 18,
                                color:
                                    dcsaNavy,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: Text(
                                  team.coachName
                                          .isEmpty
                                      ? 'No Coach Assigned'
                                      : team
                                          .coachName,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal:
                                  10,
                              vertical:
                                  6,
                            ),
                            decoration:
                                BoxDecoration(
                              color: dcsaNavy
                                  .withOpacity(
                                0.08,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                20,
                              ),
                            ),
                            child: Text(
                              '$playerCount Players',
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight
                                        .bold,
                                color:
                                    dcsaNavy,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}