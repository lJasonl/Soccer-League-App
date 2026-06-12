import 'package:flutter/material.dart';

import '../players/players_screen.dart';
import '../teams/teams_screen.dart';
import '../schedules/schedules_screen.dart';
import '../standings/standings_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soccer League Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _menuCard(
              context,
              'Teams',
              Icons.groups,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TeamsScreen(),
                  ),
                );
              },
            ),
            _menuCard(
              context,
              'Players',
              Icons.person,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlayersScreen(),
                  ),
                );
              },
            ),
            _menuCard(
              context,
              'Schedules',
              Icons.calendar_month,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SchedulesScreen(),
                  ),
                );
              },
            ),
            _menuCard(
              context,
              'Standings',
              Icons.emoji_events,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StandingsScreen(),
                  ),
                );
              },
            ),
            _menuCard(
              context,
              'Payments',
              Icons.payment,
              null,
            ),
            _menuCard(
              context,
              'Admin',
              Icons.admin_panel_settings,
              null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}