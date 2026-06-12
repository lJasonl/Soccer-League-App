import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/teams/teams_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case '/dashboard':
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );

      case '/teams':
        return MaterialPageRoute(
          builder: (_) => const TeamsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}