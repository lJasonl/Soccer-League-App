class Game {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String gameDate;
  final String gameTime;
  final String field;

  const Game({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.gameDate,
    required this.gameTime,
    required this.field,
  });
}