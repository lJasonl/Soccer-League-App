import 'package:hive/hive.dart';

class SessionService {
  static const String sessionBox =
      'session';

  static const String currentUserKey =
      'currentUserId';

  static Future<void> initialize() async {
    if (!Hive.isBoxOpen(sessionBox)) {
      await Hive.openBox(
        sessionBox,
      );
    }
  }

  static Future<void> setCurrentUserId(
    String userId,
  ) async {
    final box = Hive.box(
      sessionBox,
    );

    await box.put(
      currentUserKey,
      userId,
    );
  }

  static String? getCurrentUserId() {
    final box = Hive.box(
      sessionBox,
    );

    return box.get(
      currentUserKey,
    );
  }

  static Future<void> logout() async {
    final box = Hive.box(
      sessionBox,
    );

    await box.delete(
      currentUserKey,
    );
  }
}