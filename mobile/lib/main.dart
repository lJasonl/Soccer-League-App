import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'theme/app_theme.dart';
import 'router/app_router.dart';
import 'services/storage_service.dart';
import 'services/team_data_service.dart';
import 'services/game_data_service.dart';
import 'services/player_data_service.dart';
import 'services/registration_data_service.dart';
import 'services/payment_data_service.dart';
import 'services/settings_data_service.dart';
import 'services/season_data_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await StorageService.initialize();

  await TeamDataService.loadTeams();
  await PlayerDataService.loadPlayers();
  await GameDataService.loadGames();
  await RegistrationDataService.loadRegistrations();
  await PaymentDataService.loadPayments();
  await SettingsDataService.loadSettings();
  await SeasonDataService.loadSeasons();

  runApp(
    const SoccerLeagueApp(),
  );
}

class SoccerLeagueApp extends StatelessWidget {
  const SoccerLeagueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer League App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      onGenerateRoute:
          AppRouter.generateRoute,
    );
  }
}