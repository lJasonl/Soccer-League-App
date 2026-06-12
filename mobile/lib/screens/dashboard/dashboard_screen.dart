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
            _menuCard('Teams', Icons.groups),
            _menuCard('Players', Icons.person),
            _menuCard('Schedules', Icons.calendar_month),
            _menuCard('Standings', Icons.emoji_events),
            _menuCard('Payments', Icons.payment),
            _menuCard('Admin', Icons.admin_panel_settings),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(String title, IconData icon) {
    return Card(
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
    );
  }
}