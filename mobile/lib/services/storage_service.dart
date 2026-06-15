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
  static const String coachesBox =
      'coaches';
  static const String refereesBox =
      'referees';
  static const String usersBox =
      'users';

  static const String scholarshipsBox =
      'scholarships';

  static const String volunteerHoursBox =
      'volunteerHours';

  static const String announcementsBox =
      'announcements';

  static Future<void> initialize() async {
    await Hive.openBox(teamsBox);
    await Hive.openBox(playersBox);
    await Hive.openBox(gamesBox);
    await Hive.openBox(registrationsBox);
    await Hive.openBox(paymentsBox);
    await Hive.openBox(settingsBox);
    await Hive.openBox(seasonsBox);
    await Hive.openBox(coachesBox);
    await Hive.openBox(refereesBox);
    await Hive.openBox(usersBox);

    await Hive.openBox(
      scholarshipsBox,
    );

    await Hive.openBox(
      volunteerHoursBox,
    );

    await Hive.openBox(
      announcementsBox,
    );
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

  static Box getCoachesBox() {
    return Hive.box(coachesBox);
  }

  static Box getRefereesBox() {
    return Hive.box(refereesBox);
  }

  static Box getUsersBox() {
    return Hive.box(usersBox);
  }

  static Box getScholarshipsBox() {
    return Hive.box(
      scholarshipsBox,
    );
  }

  static Box getVolunteerHoursBox() {
    return Hive.box(
      volunteerHoursBox,
    );
  }

  static Box getAnnouncementsBox() {
    return Hive.box(
      announcementsBox,
    );
  }
}