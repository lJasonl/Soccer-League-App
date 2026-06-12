import 'package:flutter/material.dart';

import '../../services/team_data_service.dart';
import 'add_team_screen.dart';
import 'team_details_screen.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  Widget build(BuildContext context) {
    final teams = TeamDataService.teams;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTeamScreen(),
            ),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
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