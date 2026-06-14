import '../models/player.dart';
import 'player_data_service.dart';

class LeagueDataService {
  static List<Player> get players =>
      PlayerDataService.players;

  static List<Player> getPlayersForTeam(
    String teamId,
  ) {
    return PlayerDataService.getPlayersForTeam(
      teamId,
    );
  }

  static Future<void> addPlayer(
    Player player,
  ) async {
    await PlayerDataService.addPlayer(
      player,
    );
  }

  static Future<void> updatePlayer(
    Player updatedPlayer,
  ) async {
    await PlayerDataService.updatePlayer(
      updatedPlayer,
    );
  }

  static Future<void> deletePlayer(
    String playerId,
  ) async {
    await PlayerDataService.deletePlayer(
      playerId,
    );
  }
}