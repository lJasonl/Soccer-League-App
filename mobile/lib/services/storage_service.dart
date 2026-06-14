import 'package:hive/hive.dart';

class StorageService {
  static const String teamsBox = 'teams';
  static const String playersBox = 'players';
  static const String gamesBox = 'games';
  static const String registrationsBox =
      'registrations';
  static const String paymentsBox =
      'payments';
  static const String settingsBox =
      'settings';
  static const String seasonsBox =
      'seasons';

  static Future<void> initialize() async {
    await Hive.openBox(teamsBox);
    await Hive.openBox(playersBox);
    await Hive.openBox(gamesBox);
    await Hive.openBox(registrationsBox);
    await Hive.openBox(paymentsBox);
    await Hive.openBox(settingsBox);
    await Hive.openBox(seasonsBox);
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

  static Box getRegistrationsBox() {
    return Hive.box(registrationsBox);
  }

  static Box getPaymentsBox() {
    return Hive.box(paymentsBox);
  }

  static Box getSettingsBox() {
    return Hive.box(settingsBox);
  }

  static Box getSeasonsBox() {
    return Hive.box(seasonsBox);
  }
}