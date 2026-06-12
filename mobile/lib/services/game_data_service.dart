import '../models/game.dart';
import '../data/sample_games.dart';

class GameDataService {
  static final List<Game> games =
      List.from(sampleGames);

  static void addGame(Game game) {
    games.add(game);
  }

  static void updateGame(Game updatedGame) {
    final index = games.indexWhere(
      (game) => game.id == updatedGame.id,
    );

    if (index != -1) {
      games[index] = updatedGame;
    }
  }

  static void deleteGame(String gameId) {
    games.removeWhere(
      (game) => game.id == gameId,
    );
  }
}