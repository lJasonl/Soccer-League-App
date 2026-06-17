class Game {
  final String id;

  final String homeTeam;
  final String awayTeam;

  final String gameDate;
  final String gameTime;

  final String field;

  final String centerRefereeId;
  final String centerRefereeName;

  final String ar1RefereeId;
  final String ar1RefereeName;

  final String ar2RefereeId;
  final String ar2RefereeName;

  final int homeScore;
  final int awayScore;

  const Game({
    required this.id,

    required this.homeTeam,
    required this.awayTeam,

    required this.gameDate,
    required this.gameTime,

    required this.field,

    required this.centerRefereeId,
    required this.centerRefereeName,

    required this.ar1RefereeId,
    required this.ar1RefereeName,

    required this.ar2RefereeId,
    required this.ar2RefereeName,

    required this.homeScore,
    required this.awayScore,
  });
}