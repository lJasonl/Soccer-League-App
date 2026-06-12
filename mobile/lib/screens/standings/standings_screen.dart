import 'package:flutter/material.dart';

import '../../services/standings_service.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final standings =
        StandingsService.generateStandings();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standings'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
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
            rows: standings.map((team) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(team.teamName),
                  ),
                  DataCell(
                    Text(team.wins.toString()),
                  ),
                  DataCell(
                    Text(team.losses.toString()),
                  ),
                  DataCell(
                    Text(team.ties.toString()),
                  ),
                  DataCell(
                    Text(team.goalsFor.toString()),
                  ),
                  DataCell(
                    Text(
                      team.goalsAgainst.toString(),
                    ),
                  ),
                  DataCell(
                    Text(team.points.toString()),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}