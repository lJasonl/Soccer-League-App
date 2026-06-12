class TeamStanding {
  final String teamName;
  final int wins;
  final int losses;
  final int ties;
  final int goalsFor;
  final int goalsAgainst;
  final int points;

  const TeamStanding({
    required this.teamName,
    required this.wins,
    required this.losses,
    required this.ties,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.points,
  });
}