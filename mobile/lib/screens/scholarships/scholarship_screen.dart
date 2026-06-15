import 'package:flutter/material.dart';

import '../../services/scholarship_data_service.dart';
import '../../services/volunteer_data_service.dart';

import 'add_scholarship_family_screen.dart';
import 'scholarship_family_detail_screen.dart';

class ScholarshipScreen extends StatefulWidget {
  const ScholarshipScreen({
    super.key,
  });

  @override
  State<ScholarshipScreen> createState() =>
      _ScholarshipScreenState();
}

class _ScholarshipScreenState
    extends State<ScholarshipScreen> {
  static const Color dcsaNavy =
      Color(0xFF0B2A5B);

  @override
  Widget build(BuildContext context) {
    final families =
        ScholarshipDataService.families;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scholarship Program',
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
                  const AddScholarshipFamilyScreen(),
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
          'Add Family',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          Container(
            padding:
                const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              color: dcsaNavy,
              borderRadius:
                  BorderRadius.circular(
                24,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons
                      .volunteer_activism,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'DCSA Scholarship Program',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${ScholarshipDataService.activeFamilyCount} Active Families',
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: _summaryCard(
                  'Families',
                  ScholarshipDataService
                      .activeFamilyCount
                      .toString(),
                  Icons.people,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _summaryCard(
                  'Required',
                  ScholarshipDataService
                      .totalHoursRequired
                      .toString(),
                  Icons.schedule,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: _summaryCard(
                  'Completed',
                  VolunteerDataService
                      .entries
                      .fold<double>(
                        0,
                        (
                          sum,
                          entry,
                        ) =>
                            sum +
                            entry
                                .hoursWorked,
                      )
                      .toStringAsFixed(
                        1,
                      ),
                  Icons.check_circle,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _summaryCard(
                  'Entries',
                  VolunteerDataService
                      .entries
                      .length
                      .toString(),
                  Icons.assignment,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Scholarship Families',
            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (families.isEmpty)
            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(
                  24,
                ),
                child: Center(
                  child: Text(
                    'No scholarship families have been added.',
                  ),
                ),
              ),
            ),
          ...families.map(
            (family) {
              final completed =
                  VolunteerDataService
                      .getFamilyHours(
                family.id,
              );

              final progress =
                  family.hoursRequired ==
                          0
                      ? 0.0
                      : completed /
                          family
                              .hoursRequired;

              return Card(
                child: InkWell(
                  borderRadius:
                      BorderRadius
                          .circular(
                    16,
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ScholarshipFamilyDetailScreen(
                          family:
                              family,
                        ),
                      ),
                    );

                    if (mounted) {
                      setState(
                        () {},
                      );
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets
                            .all(
                      16,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          family
                              .familyName,
                          style:
                              const TextStyle(
                            fontSize:
                                18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          family
                              .primaryContact,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        LinearProgressIndicator(
                          value: progress >
                                  1
                              ? 1
                              : progress,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${completed.toStringAsFixed(1)} / ${family.hoursRequired} Hours',
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Tap to view volunteer history',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(
          12,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: dcsaNavy,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              title,
              style:
                  const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}