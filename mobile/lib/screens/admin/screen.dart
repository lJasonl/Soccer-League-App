import 'package:flutter/material.dart';

import 'registration_fee_screen.dart';
import 'season_management_screen.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Panel',
        ),
      ),
      body: ListView(
        children: [
          _AdminTile(
            icon: Icons.settings,
            title: 'League Settings',
            onTap: null,
          ),
          _AdminTile(
            icon: Icons.attach_money,
            title:
                'Registration Fee Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const RegistrationFeeScreen(),
                ),
              );
            },
          ),
          _AdminTile(
            icon: Icons.calendar_month,
            title:
                'Season Management',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SeasonManagementScreen(),
                ),
              );
            },
          ),
          _AdminTile(
            icon: Icons.sports_soccer,
            title: 'Coach Management',
            onTap: null,
          ),
          _AdminTile(
            icon: Icons.gavel,
            title: 'Referee Management',
            onTap: null,
          ),
          _AdminTile(
            icon: Icons.people,
            title: 'User Roles',
            onTap: null,
          ),
        ],
      ),
    );
  }
}

class _AdminTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _AdminTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: onTap,
      ),
    );
  }
}