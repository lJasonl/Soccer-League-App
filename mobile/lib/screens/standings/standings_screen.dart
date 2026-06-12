import 'package:flutter/material.dart';

import '../../data/sample_standings.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Standings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Team')),
            DataColumn(label: Text('W')),
            DataColumn(label: Text('L')),
            DataColumn(label: Text('T')),
            DataColumn(label: Text('GF')),
            DataColumn(label: Text('GA')),
            DataColumn(label: Text('PTS')),
          ],
          rows: sampleStandings.map((team) {
            return DataRow(
              cells: [
                DataCell(Text(team.teamName)),
                DataCell(Text(team.wins.toString())),
                DataCell(Text(team.losses.toString())),
                DataCell(Text(team.ties.toString())),
                DataCell(Text(team.goalsFor.toString())),
                DataCell(Text(team.goalsAgainst.toString())),
                DataCell(Text(team.points.toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}