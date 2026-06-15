import 'package:flutter/material.dart';

import '../../models/coach.dart';
import '../../services/coach_data_service.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() =>
      _CoachScreenState();
}

class _CoachScreenState
    extends State<CoachScreen> {
  Future<void> _showAddCoachDialog() async {
    final firstNameController =
        TextEditingController();

    final lastNameController =
        TextEditingController();

    final emailController =
        TextEditingController();

    final phoneController =
        TextEditingController();

    final result =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Coach',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                TextField(
                  controller:
                      firstNameController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'First Name',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller:
                      lastNameController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Last Name',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller:
                      emailController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller:
                      phoneController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Phone',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child:
                  const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );

    if (result != true) {
      return;
    }

    final coach = Coach(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      firstName:
          firstNameController.text,
      lastName:
          lastNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      isActive: true,
      createdAt: DateTime.now(),
    );

    await CoachDataService.addCoach(
      coach,
    );

    setState(() {});
  }

  Future<void> _toggleCoachStatus(
    Coach coach,
  ) async {
    await CoachDataService.updateCoach(
      coach.copyWith(
        isActive:
            !coach.isActive,
      ),
    );

    setState(() {});
  }

  Future<void> _deleteCoach(
    Coach coach,
  ) async {
    await CoachDataService.deleteCoach(
      coach.id,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final coaches =
        CoachDataService.coaches;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Coach Management',
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed:
            _showAddCoachDialog,
        child:
            const Icon(Icons.add),
      ),
      body: coaches.isEmpty
          ? const Center(
              child: Text(
                'No coaches added.',
              ),
            )
          : ListView.builder(
              itemCount:
                  coaches.length,
              itemBuilder:
                  (context, index) {
                final coach =
                    coaches[index];

                return Card(
                  margin:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        coach.firstName
                                .isNotEmpty
                            ? coach
                                .firstName[0]
                            : 'C',
                      ),
                    ),
                    title: Text(
                      coach.fullName,
                    ),
                    subtitle: Text(
                      '${coach.email}\n${coach.phone}',
                    ),
                    isThreeLine: true,
                    trailing:
                        PopupMenuButton<
                            String>(
                      onSelected:
                          (value) {
                        if (value ==
                            'status') {
                          _toggleCoachStatus(
                            coach,
                          );
                        }

                        if (value ==
                            'delete') {
                          _deleteCoach(
                            coach,
                          );
                        }
                      },
                      itemBuilder:
                          (context) => [
                        PopupMenuItem(
                          value:
                              'status',
                          child: Text(
                            coach.isActive
                                ? 'Deactivate'
                                : 'Activate',
                          ),
                        ),
                        const PopupMenuItem(
                          value:
                              'delete',
                          child: Text(
                            'Delete',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}