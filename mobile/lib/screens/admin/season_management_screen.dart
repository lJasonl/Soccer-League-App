import 'package:flutter/material.dart';

import '../../models/season.dart';
import '../../services/season_data_service.dart';

class SeasonManagementScreen extends StatefulWidget {
  const SeasonManagementScreen({super.key});

  @override
  State<SeasonManagementScreen> createState() =>
      _SeasonManagementScreenState();
}

class _SeasonManagementScreenState
    extends State<SeasonManagementScreen> {
  Future<void> _addSeason() async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Season'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Season Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  controller.text.trim(),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == null || result.isEmpty) {
      return;
    }

    await SeasonDataService.addSeason(
      Season(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        name: result,
        isActive: false,
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final seasons =
        SeasonDataService.seasons;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Season Management',
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: _addSeason,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: seasons.length,
        itemBuilder: (context, index) {
          final season = seasons[index];

          return Card(
            margin:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              title: Text(season.name),
              subtitle: Text(
                season.isActive
                    ? 'Active Season'
                    : 'Inactive',
              ),
              trailing: season.isActive
                  ? const Icon(
                      Icons.check_circle,
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        await SeasonDataService
                            .setActiveSeason(
                          season.id,
                        );

                        setState(() {});
                      },
                      child: const Text(
                        'Activate',
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}