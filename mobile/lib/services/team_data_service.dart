import '../models/team.dart';
import '../data/sample_teams.dart';

class TeamDataService {
  static final List<Team> teams =
      List.from(sampleTeams);

  static void addTeam(Team team) {
    teams.add(team);
  }
}