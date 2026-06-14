import '../models/season.dart';
import 'storage_service.dart';

class SeasonDataService {
  static List<Season> seasons = [];

  static Future<void> loadSeasons() async {
    final box =
        StorageService.getSeasonsBox();

    if (box.isEmpty) {
      seasons = [
        const Season(
          id: '1',
          name: 'Fall 2026',
          isActive: true,
        ),
      ];

      await saveSeasons();
      return;
    }

    seasons = box.values.map((item) {
      final data =
          Map<String, dynamic>.from(item);

      return Season(
        id: data['id'],
        name: data['name'],
        isActive: data['isActive'],
      );
    }).toList();
  }

  static Future<void> saveSeasons() async {
    final box =
        StorageService.getSeasonsBox();

    await box.clear();

    for (final season in seasons) {
      await box.add({
        'id': season.id,
        'name': season.name,
        'isActive': season.isActive,
      });
    }
  }

  static Future<void> addSeason(
    Season season,
  ) async {
    seasons.add(season);

    await saveSeasons();
  }

  static Future<void> setActiveSeason(
    String seasonId,
  ) async {
    seasons = seasons
        .map(
          (season) => Season(
            id: season.id,
            name: season.name,
            isActive:
                season.id == seasonId,
          ),
        )
        .toList();

    await saveSeasons();
  }
}