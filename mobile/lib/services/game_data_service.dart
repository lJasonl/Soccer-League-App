import '../models/game.dart';
import '../data/sample_games.dart';

class GameDataService {
  static final List<Game> games =
      List.from(sampleGames);

  static void addGame(Game game) {
    games.add(game);
  }
}