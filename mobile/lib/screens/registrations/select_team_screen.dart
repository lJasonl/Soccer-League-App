import 'package:flutter/material.dart';

import '../../models/team.dart';
import '../../services/team_data_service.dart';

class SelectTeamScreen extends StatelessWidget {
  const SelectTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teams = TeamDataService.teams;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Team'),
      ),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: const Icon(Icons.groups),
              title: Text(team.name),
              subtitle: Text(
                '${team.division} • ${team.coach}',
              ),
              onTap: () {
                Navigator.pop<Team>(
                  context,
                  team,
                );
              },
            ),
          );
        },
      ),
    );
  }
}