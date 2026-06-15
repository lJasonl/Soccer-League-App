import 'package:flutter/material.dart';

import '../../services/game_data_service.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final standings =
        _buildStandings();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Standings',
        ),
      ),
      body: standings.isEmpty
          ? const Center(
              child: Text(
                'No completed games available.',
              ),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.all(12),
              itemCount:
                  standings.length,
              itemBuilder:
                  (context, index) {
                final team =
                    standings[index];

                String medal = '';

                if (index == 0) {
                  medal = '🥇';
                } else if (index == 1) {
                  medal = '🥈';
                } else if (index == 2) {
                  medal = '🥉';
                }

                return Card(
                  margin:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),
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
                        Text(
                          '$medal #${index + 1} ${team.name}',
                          style:
                              const TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Text(
                          '${team.points} Points',
                          style:
                              const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const Divider(),

                        Text(
                          'Games Played: ${team.gamesPlayed}',
                        ),

                        Text(
                          'Record: ${team.wins}-${team.losses}-${team.draws}',
                        ),

                        Text(
                          'Goals For: ${team.goalsFor}',
                        ),

                        Text(
                          'Goals Against: ${team.goalsAgainst}',
                        ),

                        Text(
                          'Goal Difference: ${team.goalDifference >= 0 ? '+' : ''}${team.goalDifference}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  List<_Standing>
      _buildStandings() {
    final Map<String, _Standing>
        table = {};

    for (final game
        in GameDataService.games) {
      final home =
          table.putIfAbsent(
        game.homeTeam,
        () => _Standing(
          name:
              game.homeTeam,
        ),
      );

      final away =
          table.putIfAbsent(
        game.awayTeam,
        () => _Standing(
          name:
              game.awayTeam,
        ),
      );

      home.gamesPlayed++;
      away.gamesPlayed++;

      home.goalsFor +=
          game.homeScore;
      home.goalsAgainst +=
          game.awayScore;

      away.goalsFor +=
          game.awayScore;
      away.goalsAgainst +=
          game.homeScore;

      if (game.homeScore >
          game.awayScore) {
        home.wins++;
        home.points += 3;

        away.losses++;
      } else if (game.awayScore >
          game.homeScore) {
        away.wins++;
        away.points += 3;

        home.losses++;
      } else {
        home.draws++;
        away.draws++;

        home.points++;
        away.points++;
      }
    }

    final standings =
        table.values.toList();

    standings.sort(
      (a, b) {
        final pointsCompare =
            b.points.compareTo(
          a.points,
        );

        if (pointsCompare != 0) {
          return pointsCompare;
        }

        final gdCompare =
            b.goalDifference
                .compareTo(
          a.goalDifference,
        );

        if (gdCompare != 0) {
          return gdCompare;
        }

        return b.goalsFor
            .compareTo(
          a.goalsFor,
        );
      },
    );

    return standings;
  }
}

class _Standing {
  final String name;

  int gamesPlayed = 0;

  int wins = 0;
  int losses = 0;
  int draws = 0;

  int goalsFor = 0;
  int goalsAgainst = 0;

  int points = 0;

  _Standing({
    required this.name,
  });

  int get goalDifference =>
      goalsFor - goalsAgainst;
}