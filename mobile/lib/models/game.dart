class Game {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String gameDate;
  final String gameTime;
  final String field;

  final String refereeId;
  final String refereeName;

  final int homeScore;
  final int awayScore;

  const Game({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.gameDate,
    required this.gameTime,
    required this.field,
    required this.refereeId,
    required this.refereeName,
    required this.homeScore,
    required this.awayScore,
  });
}