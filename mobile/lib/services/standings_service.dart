import '../models/team_standing.dart';
import '../services/game_data_service.dart';

class StandingsService {
  static List<TeamStanding> generateStandings() {
    final Map<String, TeamStanding> table = {};

    for (final game in GameDataService.games) {
      table.putIfAbsent(
        game.homeTeam,
        () => TeamStanding(
          teamName: game.homeTeam,
          wins: 0,
          losses: 0,
          ties: 0,
          goalsFor: 0,
          goalsAgainst: 0,
          points: 0,
        ),
      );

      table.putIfAbsent(
        game.awayTeam,
        () => TeamStanding(
          teamName: game.awayTeam,
          wins: 0,
          losses: 0,
          ties: 0,
          goalsFor: 0,
          goalsAgainst: 0,
          points: 0,
        ),
      );
    }

    final Map<String, _StandingBuilder> builders = {};

    for (final team in table.keys) {
      builders[team] = _StandingBuilder(team);
    }

    for (final game in GameDataService.games) {
      final home = builders[game.homeTeam]!;
      final away = builders[game.awayTeam]!;

      home.goalsFor += game.homeScore;
      home.goalsAgainst += game.awayScore;

      away.goalsFor += game.awayScore;
      away.goalsAgainst += game.homeScore;

      if (game.homeScore > game.awayScore) {
        home.wins++;
        home.points += 3;
        away.losses++;
      } else if (game.awayScore > game.homeScore) {
        away.wins++;
        away.points += 3;
        home.losses++;
      } else {
        home.ties++;
        away.ties++;
        home.points++;
        away.points++;
      }
    }

    final standings = builders.values
        .map((builder) => builder.build())
        .toList();

    standings.sort(
      (a, b) => b.points.compareTo(a.points),
    );

    return standings;
  }
}

class _StandingBuilder {
  final String teamName;

  int wins = 0;
  int losses = 0;
  int ties = 0;
  int goalsFor = 0;
  int goalsAgainst = 0;
  int points = 0;

  _StandingBuilder(this.teamName);

  TeamStanding build() {
    return TeamStanding(
      teamName: teamName,
      wins: wins,
      losses: losses,
      ties: ties,
      goalsFor: goalsFor,
      goalsAgainst: goalsAgainst,
      points: points,
    );
  }
}