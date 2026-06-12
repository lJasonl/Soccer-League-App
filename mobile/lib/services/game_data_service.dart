import '../models/game.dart';
import 'storage_service.dart';

class GameDataService {
  static List<Game> games = [];

  static Future<void> loadGames() async {
    final box = StorageService.getGamesBox();

    if (box.isEmpty) {
      return;
    }

    games = box.values.map((item) {
      final data = Map<String, dynamic>.from(item);

      return Game(
        id: data['id'],
        homeTeam: data['homeTeam'],
        awayTeam: data['awayTeam'],
        gameDate: data['gameDate'],
        gameTime: data['gameTime'],
        field: data['field'],
        homeScore: data['homeScore'],
        awayScore: data['awayScore'],
      );
    }).toList();
  }

  static Future<void> saveGames() async {
    final box = StorageService.getGamesBox();

    await box.clear();

    for (final game in games) {
      await box.add({
        'id': game.id,
        'homeTeam': game.homeTeam,
        'awayTeam': game.awayTeam,
        'gameDate': game.gameDate,
        'gameTime': game.gameTime,
        'field': game.field,
        'homeScore': game.homeScore,
        'awayScore': game.awayScore,
      });
    }
  }

  static Future<void> addGame(
    Game game,
  ) async {
    games.add(game);
    await saveGames();
  }

  static Future<void> updateGame(
    Game updatedGame,
  ) async {
    final index = games.indexWhere(
      (game) => game.id == updatedGame.id,
    );

    if (index != -1) {
      games[index] = updatedGame;
      await saveGames();
    }
  }

  static Future<void> deleteGame(
    String gameId,
  ) async {
    games.removeWhere(
      (game) => game.id == gameId,
    );

    await saveGames();
  }
}