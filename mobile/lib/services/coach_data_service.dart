import '../models/coach.dart';
import 'storage_service.dart';

class CoachDataService {
  static List<Coach> coaches = [];

  static Future<void> loadCoaches() async {
    final box = StorageService.getCoachesBox();

    print('Hive coach count: ${box.length}');

    if (box.isEmpty) {
      print('Hive coach box empty');
      return;
    }

    coaches = box.values.map((item) {
      final data = Map<String, dynamic>.from(item);

      return Coach(
        id: data['id'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        isActive: data['isActive'] ?? true,
        createdAt:
            DateTime.tryParse(
              data['createdAt'] ?? '',
            ) ??
            DateTime.now(),
      );
    }).toList();

    print(
      'Loaded ${coaches.length} coaches from Hive',
    );
  }

  static Future<void> saveCoaches() async {
    final box = StorageService.getCoachesBox();

    await box.clear();

    for (final coach in coaches) {
      await box.add({
        'id': coach.id,
        'firstName': coach.firstName,
        'lastName': coach.lastName,
        'email': coach.email,
        'phone': coach.phone,
        'isActive': coach.isActive,
        'createdAt':
            coach.createdAt.toIso8601String(),
      });
    }

    print(
      'Saved ${coaches.length} coaches to Hive',
    );
  }

  static Future<void> addCoach(
    Coach coach,
  ) async {
    coaches.add(coach);

    await saveCoaches();
  }

  static Future<void> updateCoach(
    Coach updatedCoach,
  ) async {
    final index = coaches.indexWhere(
      (coach) =>
          coach.id == updatedCoach.id,
    );

    if (index != -1) {
      coaches[index] = updatedCoach;

      await saveCoaches();
    }
  }

  static Future<void> deleteCoach(
    String coachId,
  ) async {
    coaches.removeWhere(
      (coach) => coach.id == coachId,
    );

    await saveCoaches();
  }
}