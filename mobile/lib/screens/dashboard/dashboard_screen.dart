import 'package:flutter/material.dart';

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
              '/teams',
            ),
            _menuCard(
              context,
              'Players',
              Icons.person,
            ),
            _menuCard(
              context,
              'Schedules',
              Icons.calendar_month,
            ),
            _menuCard(
              context,
              'Standings',
              Icons.emoji_events,
            ),
            _menuCard(
              context,
              'Payments',
              Icons.payment,
            ),
            _menuCard(
              context,
              'Admin',
              Icons.admin_panel_settings,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context,
    String title,
    IconData icon, [
    String? route,
  ]) {
    return InkWell(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title module coming soon'),
            ),
          );
        }
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
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