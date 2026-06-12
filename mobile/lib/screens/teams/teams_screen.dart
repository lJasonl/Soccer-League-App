import 'package:flutter/material.dart';

import '../../data/sample_teams.dart';
import 'team_details_screen.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
      ),
      body: ListView.builder(
        itemCount: sampleTeams.length,
        itemBuilder: (context, index) {
          final team = sampleTeams[index];

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
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TeamDetailsScreen(
                      team: team,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}