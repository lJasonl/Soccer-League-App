import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'router/app_router.dart';

void main() {
  runApp(const SoccerLeagueApp());
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