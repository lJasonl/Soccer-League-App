import '../models/scholarship_family.dart';
import 'storage_service.dart';

class ScholarshipDataService {
  static List<ScholarshipFamily>
      families = [];

  static Future<void>
      loadFamilies() async {
    final box =
        StorageService.getScholarshipsBox();

    print(
      'Hive scholarship count: ${box.length}',
    );

    if (box.isEmpty) {
      print(
        'Hive scholarship box empty',
      );
      return;
    }

    families = box.values.map((item) {
      final data =
          Map<String, dynamic>.from(
        item,
      );

      return ScholarshipFamily(
        id: data['id'] ?? '',
        familyName:
            data['familyName'] ?? '',
        primaryContact:
            data['primaryContact'] ??
                '',
        hoursRequired:
            data['hoursRequired'] ?? 0,
        hoursCompleted:
            data['hoursCompleted'] ??
                0,
        notes:
            data['notes'] ?? '',
        isActive:
            data['isActive'] ?? true,
      );
    }).toList();

    print(
      'Loaded ${families.length} scholarship families from Hive',
    );
  }

  static Future<void>
      saveFamilies() async {
    final box =
        StorageService.getScholarshipsBox();

    await box.clear();

    for (final family
        in families) {
      await box.add({
        'id': family.id,
        'familyName':
            family.familyName,
        'primaryContact':
            family.primaryContact,
        'hoursRequired':
            family.hoursRequired,
        'hoursCompleted':
            family.hoursCompleted,
        'notes': family.notes,
        'isActive':
            family.isActive,
      });
    }

    print(
      'Saved ${families.length} scholarship families to Hive',
    );
  }

  static Future<void>
      addFamily(
    ScholarshipFamily family,
  ) async {
    families.add(family);

    await saveFamilies();
  }

  static Future<void>
      updateFamily(
    ScholarshipFamily family,
  ) async {
    final index =
        families.indexWhere(
      (f) => f.id == family.id,
    );

    if (index != -1) {
      families[index] = family;

      await saveFamilies();
    }
  }

  static Future<void>
      deleteFamily(
    String familyId,
  ) async {
    families.removeWhere(
      (f) => f.id == familyId,
    );

    await saveFamilies();
  }

  static int get activeFamilyCount {
    return families.where(
      (family) => family.isActive,
    ).length;
  }

  static int get totalHoursRequired {
    return families.fold(
      0,
      (sum, family) =>
          sum +
          family.hoursRequired,
    );
  }

  static int get totalHoursCompleted {
    return families.fold(
      0,
      (sum, family) =>
          sum +
          family.hoursCompleted,
    );
  }

  static int get totalHoursRemaining {
    return families.fold(
      0,
      (sum, family) =>
          sum +
          family.hoursRemaining,
    );
  }
}