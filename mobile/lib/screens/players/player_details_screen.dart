import 'package:flutter/material.dart';

import '../../models/player.dart';

class PlayerDetailsScreen extends StatelessWidget {
  final Player player;

  const PlayerDetailsScreen({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.fullName),
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
                      player.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Jersey Number: #${player.jerseyNumber}'),
                    Text('Birth Year: ${player.birthYear}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Parent / Guardian'),
                subtitle: Text(player.parentName),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Parent Phone'),
                subtitle: Text(player.parentPhone),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.badge),
                title: const Text('Registration Status'),
                subtitle: Text(player.registrationStatus),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.medical_services),
                title: Text('Medical Information'),
                subtitle: Text('Not entered'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}