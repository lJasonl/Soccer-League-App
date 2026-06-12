import 'package:hive/hive.dart';

class StorageService {
  static const String teamsBox = 'teams';
  static const String playersBox = 'players';
  static const String gamesBox = 'games';

  static Future<void> initialize() async {
    await Hive.openBox(teamsBox);
    await Hive.openBox(playersBox);
    await Hive.openBox(gamesBox);
  }

  static Box getTeamsBox() {
    return Hive.box(teamsBox);
  }

  static Box getPlayersBox() {
    return Hive.box(playersBox);
  }

  static Box getGamesBox() {
    return Hive.box(gamesBox);
  }
}