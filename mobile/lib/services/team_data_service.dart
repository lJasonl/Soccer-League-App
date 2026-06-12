import '../models/team.dart';
import '../data/sample_teams.dart';

class TeamDataService {
  static final List<Team> teams =
      List.from(sampleTeams);

  static void addTeam(Team team) {
    teams.add(team);
  }

  static void updateTeam(Team updatedTeam) {
    final index = teams.indexWhere(
      (team) => team.id == updatedTeam.id,
    );

    if (index != -1) {
      teams[index] = updatedTeam;
    }
  }

  static void deleteTeam(String teamId) {
    teams.removeWhere(
      (team) => team.id == teamId,
    );
  }
}