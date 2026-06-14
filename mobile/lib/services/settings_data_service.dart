import '../models/league_settings.dart';
import 'storage_service.dart';

class SettingsDataService {
  static LeagueSettings settings =
      const LeagueSettings(
        registrationFee: 50.0,
      );

  static Future<void> loadSettings() async {
    final box =
        StorageService.getSettingsBox();

    if (box.isEmpty) {
      return;
    }

    settings = LeagueSettings(
      registrationFee:
          (box.get(
                'registrationFee',
                defaultValue: 50.0,
              ) as num)
              .toDouble(),
    );
  }

  static Future<void> saveSettings() async {
    final box =
        StorageService.getSettingsBox();

    await box.put(
      'registrationFee',
      settings.registrationFee,
    );
  }

  static Future<void>
      updateRegistrationFee(
    double fee,
  ) async {
    settings = LeagueSettings(
      registrationFee: fee,
    );

    await saveSettings();
  }
}