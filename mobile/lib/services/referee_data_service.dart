import '../models/referee.dart';
import 'storage_service.dart';

class RefereeDataService {
  static List<Referee> referees = [];

  static Future<void> loadReferees() async {
    final box =
        StorageService.getRefereesBox();

    if (box.isEmpty) {
      return;
    }

    referees = box.values.map((item) {
      final data =
          Map<String, dynamic>.from(
        item,
      );

      return Referee(
        id: data['id'] ?? '',
        firstName:
            data['firstName'] ?? '',
        lastName:
            data['lastName'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        isActive:
            data['isActive'] ?? true,
        createdAt:
            DateTime.tryParse(
                  data['createdAt'] ??
                      '',
                ) ??
                DateTime.now(),
      );
    }).toList();
  }

  static Future<void> saveReferees()
      async {
    final box =
        StorageService.getRefereesBox();

    await box.clear();

    for (final referee in referees) {
      await box.add({
        'id': referee.id,
        'firstName':
            referee.firstName,
        'lastName':
            referee.lastName,
        'email': referee.email,
        'phone': referee.phone,
        'isActive':
            referee.isActive,
        'createdAt': referee
            .createdAt
            .toIso8601String(),
      });
    }
  }

  static Future<void> addReferee(
    Referee referee,
  ) async {
    referees.add(referee);

    await saveReferees();
  }

  static Future<void> updateReferee(
    Referee referee,
  ) async {
    final index =
        referees.indexWhere(
      (r) => r.id == referee.id,
    );

    if (index != -1) {
      referees[index] = referee;

      await saveReferees();
    }
  }

  static Future<void> deleteReferee(
    String refereeId,
  ) async {
    referees.removeWhere(
      (r) => r.id == refereeId,
    );

    await saveReferees();
  }
}