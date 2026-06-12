import '../models/team.dart';
import '../data/sample_teams.dart';
import 'storage_service.dart';

class TeamDataService {
  static List<Team> teams = List.from(sampleTeams);

  static Future<void> loadTeams() async {
    final box = StorageService.getTeamsBox();

    print('Hive team count: ${box.length}');

    if (box.isEmpty) {
      print('Hive box empty');
      return;
    }

    teams = box.values.map((item) {
      final data = Map<String, dynamic>.from(item);

      return Team(
        id: data['id'],
        name: data['name'],
        division: data['division'],
        coach: data['coach'],
      );
    }).toList();

    print(
      'Loaded ${teams.length} teams from Hive',
    );
  }

  static Future<void> saveTeams() async {
    final box = StorageService.getTeamsBox();

    await box.clear();

    for (final team in teams) {
      await box.add({
        'id': team.id,
        'name': team.name,
        'division': team.division,
        'coach': team.coach,
      });
    }

    print(
      'Saved ${teams.length} teams to Hive',
    );
  }

  static Future<void> addTeam(
    Team team,
  ) async {
    teams.add(team);

    await saveTeams();
  }

  static Future<void> updateTeam(
    Team updatedTeam,
  ) async {
    final index = teams.indexWhere(
      (team) => team.id == updatedTeam.id,
    );

    if (index != -1) {
      teams[index] = updatedTeam;

      await saveTeams();
    }
  }

  static Future<void> deleteTeam(
    String teamId,
  ) async {
    teams.removeWhere(
      (team) => team.id == teamId,
    );

    await saveTeams();
  }
}