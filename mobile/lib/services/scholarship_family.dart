import '../models/scholarship_family.dart';

class ScholarshipDataService {
  static List<ScholarshipFamily>
      families = [];

  static Future<void>
      loadFamilies() async {}

  static Future<void>
      saveFamilies() async {}

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

  static int get activeFamilyCount {
    return families.where(
      (family) => family.isActive,
    ).length;
  }
}