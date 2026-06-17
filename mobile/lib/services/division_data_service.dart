import '../models/division.dart';
import 'storage_service.dart';

class DivisionDataService {
  static List<Division>
      divisions = [];

  static Future<void>
      loadDivisions() async {
    final box =
        StorageService
            .getDivisionsBox();

    if (box.isEmpty) {
      divisions = [
        const Division(
          id: '1',
          name: 'U7',
          isActive: true,
        ),
        const Division(
          id: '2',
          name: 'U9',
          isActive: true,
        ),
        const Division(
          id: '3',
          name: 'U11',
          isActive: true,
        ),
        const Division(
          id: '4',
          name: 'U13',
          isActive: true,
        ),
        const Division(
          id: '5',
          name: 'U15',
          isActive: true,
        ),
      ];

      await saveDivisions();
      return;
    }

    divisions =
        box.values.map((item) {
      final data =
          Map<String, dynamic>.from(
        item,
      );

      return Division(
        id: data['id'],
        name: data['name'],
        isActive:
            data['isActive'],
      );
    }).toList();
  }

  static Future<void>
      saveDivisions() async {
    final box =
        StorageService
            .getDivisionsBox();

    await box.clear();

    for (final division
        in divisions) {
      await box.add({
        'id': division.id,
        'name':
            division.name,
        'isActive':
            division.isActive,
      });
    }
  }

  static Future<void>
      addDivision(
    Division division,
  ) async {
    divisions.add(
      division,
    );

    await saveDivisions();
  }

  static Future<void>
      deleteDivision(
    String divisionId,
  ) async {
    divisions.removeWhere(
      (division) =>
          division.id ==
          divisionId,
    );

    await saveDivisions();
  }

  static Future<void>
      toggleDivisionStatus(
    String divisionId,
  ) async {
    divisions = divisions
        .map(
          (division) =>
              division.id ==
                      divisionId
                  ? Division(
                      id:
                          division.id,
                      name:
                          division.name,
                      isActive:
                          !division
                              .isActive,
                    )
                  : division,
        )
        .toList();

    await saveDivisions();
  }

  static List<Division>
      get activeDivisions {
    return divisions
        .where(
          (division) =>
              division
                  .isActive,
        )
        .toList();
  }
}