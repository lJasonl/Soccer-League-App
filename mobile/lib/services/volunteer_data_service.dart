import '../models/volunteer_entry.dart';
import 'storage_service.dart';

class VolunteerDataService {
  static List<VolunteerEntry> entries = [];

  static Future<void> loadEntries() async {
    final box =
        StorageService.getVolunteerHoursBox();

    entries = box.values.map((item) {
      final data =
          Map<String, dynamic>.from(item);

      return VolunteerEntry(
        id: data['id'],
        familyId: data['familyId'],
        dateWorked: DateTime.parse(
          data['dateWorked'],
        ),
        hoursWorked:
            (data['hoursWorked'] as num)
                .toDouble(),
        activityType:
            data['activityType'],
        notes: data['notes'],
      );
    }).toList();
  }

  static Future<void> saveEntries() async {
    final box =
        StorageService.getVolunteerHoursBox();

    await box.clear();

    for (final entry in entries) {
      await box.add({
        'id': entry.id,
        'familyId': entry.familyId,
        'dateWorked': entry.dateWorked
            .toIso8601String(),
        'hoursWorked':
            entry.hoursWorked,
        'activityType':
            entry.activityType,
        'notes': entry.notes,
      });
    }
  }

  static Future<void> addEntry(
    VolunteerEntry entry,
  ) async {
    entries.add(entry);

    await saveEntries();
  }

  static List<VolunteerEntry>
      getFamilyEntries(
    String familyId,
  ) {
    return entries
        .where(
          (e) => e.familyId == familyId,
        )
        .toList();
  }

  static double getFamilyHours(
    String familyId,
  ) {
    return getFamilyEntries(
      familyId,
    ).fold(
      0.0,
      (sum, e) =>
          sum + e.hoursWorked,
    );
  }
}