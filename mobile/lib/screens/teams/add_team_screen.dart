import 'package:flutter/material.dart';

import '../../models/coach.dart';
import '../../models/team.dart';
import '../../models/division.dart';

import '../../services/coach_data_service.dart';
import '../../services/team_data_service.dart';
import '../../services/division_data_service.dart';

class AddTeamScreen extends StatefulWidget {
  const AddTeamScreen({super.key});

  @override
  State<AddTeamScreen> createState() =>
      _AddTeamScreenState();
}

class _AddTeamScreenState
    extends State<AddTeamScreen> {
  final _formKey =
      GlobalKey<FormState>();

  final _teamNameController =
      TextEditingController();

  String? _division;

  Coach? _selectedCoach;

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  Future<void> _saveTeam() async {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    final team = Team(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      name: _teamNameController.text
          .trim(),
      division:
          _division ?? '',
      coachId:
          _selectedCoach?.id ?? '',
      coachName:
          _selectedCoach
                  ?.fullName ??
              '',
    );

    await TeamDataService.addTeam(
      team,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final availableCoaches =
        CoachDataService.coaches
            .where(
              (coach) =>
                  coach.isActive &&
                  !TeamDataService
                      .isCoachAssigned(
                    coach.id,
                  ),
            )
            .toList();

    final List<Division>
        divisions =
        DivisionDataService
            .activeDivisions;

    if (_division == null &&
        divisions.isNotEmpty) {
      _division =
          divisions.first.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Team',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller:
                    _teamNameController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Team Name',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Enter team name';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                  String>(
                value: _division,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Division',
                  border:
                      OutlineInputBorder(),
                ),
                items: divisions
                    .map(
                      (division) =>
                          DropdownMenuItem<
                              String>(
                        value:
                            division.name,
                        child: Text(
                          division.name,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _division =
                        value;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                  Coach>(
                decoration:
                    const InputDecoration(
                  labelText:
                      'Coach',
                  border:
                      OutlineInputBorder(),
                ),
                items:
                    availableCoaches
                        .map(
                          (coach) =>
                              DropdownMenuItem<
                                  Coach>(
                            value:
                                coach,
                            child: Text(
                              coach
                                  .fullName,
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (coach) {
                  setState(() {
                    _selectedCoach =
                        coach;
                  });
                },
              ),

              const SizedBox(
                height: 24,
              ),

              SizedBox(
                width:
                    double.infinity,
                child:
                    ElevatedButton(
                  onPressed:
                      _saveTeam,
                  child:
                      const Text(
                    'Save Team',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}