import 'package:flutter/material.dart';

class TeamDetailsScreen extends StatelessWidget {
  final String teamName;
  final String division;
  final String coach;

  const TeamDetailsScreen({
    super.key,
    required this.teamName,
    required this.division,
    required this.coach,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teamName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teamName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Division: $division'),
                    Text('Coach: $coach'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('Players'),
                subtitle: Text('No players added yet'),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.calendar_month),
                title: Text('Schedule'),
                subtitle: Text('No games scheduled'),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.emoji_events),
                title: Text('Standings'),
                subtitle: Text('Wins: 0  Losses: 0  Draws: 0'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}