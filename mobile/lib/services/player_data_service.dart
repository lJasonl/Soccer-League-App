import '../data/sample_players.dart';
import '../models/player.dart';
import 'storage_service.dart';

class PlayerDataService {
  static List<Player> players =
      List.from(samplePlayers);

  static Future<void> loadPlayers() async {
    final box = StorageService.getPlayersBox();

    if (box.isEmpty) {
      return;
    }

    players = box.values.map((item) {
      final data = Map<String, dynamic>.from(item);

      return Player(
        id: data['id'],
        teamId: data['teamId'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        jerseyNumber: data['jerseyNumber'],
        birthYear: data['birthYear'],
        parentName: data['parentName'],
        parentPhone: data['parentPhone'],
        registrationStatus:
            data['registrationStatus'],
      );
    }).toList();
  }

  static Future<void> savePlayers() async {
    final box = StorageService.getPlayersBox();

    await box.clear();

    for (final player in players) {
      await box.add({
        'id': player.id,
        'teamId': player.teamId,
        'firstName': player.firstName,
        'lastName': player.lastName,
        'jerseyNumber': player.jerseyNumber,
        'birthYear': player.birthYear,
        'parentName': player.parentName,
        'parentPhone': player.parentPhone,
        'registrationStatus':
            player.registrationStatus,
      });
    }
  }

  static Future<void> addPlayer(
    Player player,
  ) async {
    players.add(player);

    await savePlayers();
  }

  static Future<void> updatePlayer(
    Player updatedPlayer,
  ) async {
    final index = players.indexWhere(
      (player) => player.id == updatedPlayer.id,
    );

    if (index != -1) {
      players[index] = updatedPlayer;

      await savePlayers();
    }
  }

  static Future<void> deletePlayer(
    String playerId,
  ) async {
    players.removeWhere(
      (player) => player.id == playerId,
    );

    await savePlayers();
  }

  static List<Player> getPlayersForTeam(
    String teamId,
  ) {
    return players.where((player) {
      return player.teamId == teamId;
    }).toList();
  }
}