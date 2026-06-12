import '../models/player.dart';
import '../data/sample_players.dart';

class LeagueDataService {
  static final List<Player> players = List.from(samplePlayers);

  static List<Player> getPlayersForTeam(String teamId) {
    return players.where((player) {
      return player.teamId == teamId;
    }).toList();
  }

  static void addPlayer(Player player) {
    players.add(player);
  }
}