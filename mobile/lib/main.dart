import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'theme/app_theme.dart';
import 'router/app_router.dart';
import 'services/storage_service.dart';
import 'services/team_data_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await StorageService.initialize();

  await TeamDataService.loadTeams();

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
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}