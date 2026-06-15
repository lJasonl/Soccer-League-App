import 'package:flutter/material.dart';

import '../../models/scholarship_family.dart';
import '../../services/volunteer_data_service.dart';
import 'add_volunteer_hours_screen.dart';

class ScholarshipFamilyDetailScreen
    extends StatefulWidget {
  final ScholarshipFamily family;

  const ScholarshipFamilyDetailScreen({
    super.key,
    required this.family,
  });

  @override
  State<ScholarshipFamilyDetailScreen>
      createState() =>
          _ScholarshipFamilyDetailScreenState();
}

class _ScholarshipFamilyDetailScreenState
    extends State<
        ScholarshipFamilyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final entries =
        VolunteerDataService
            .getFamilyEntries(
      widget.family.id,
    );

    final completed =
        VolunteerDataService
            .getFamilyHours(
      widget.family.id,
    );

    final progress =
        widget.family.hoursRequired == 0
            ? 0.0
            : completed /
                widget.family.hoursRequired;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.family.familyName,
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () async {
          final result =
              await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddVolunteerHoursScreen(
                family:
                    widget.family,
              ),
            ),
          );

          if (result == true &&
              mounted) {
            setState(() {});
          }
        },
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          'Add Hours',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    widget.family
                        .primaryContact,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LinearProgressIndicator(
                    value: progress > 1
                        ? 1
                        : progress,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '${completed.toStringAsFixed(1)} / ${widget.family.hoursRequired} Hours',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Volunteer History',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          if (entries.isEmpty)
            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(
                  20,
                ),
                child: Text(
                  'No volunteer hours logged.',
                ),
              ),
            ),
          ...entries.map(
            (entry) => Card(
              child: ListTile(
                title: Text(
                  entry.activityType,
                ),
                subtitle: Text(
                  '${entry.dateWorked.month}/${entry.dateWorked.day}/${entry.dateWorked.year}\n${entry.notes}',
                ),
                trailing: Text(
                  '${entry.hoursWorked} hrs',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}