import 'package:flutter/material.dart';

import '../../models/coach.dart';
import '../../models/team.dart';
import '../../services/coach_data_service.dart';
import '../../services/team_data_service.dart';

class EditTeamScreen extends StatefulWidget {
  final Team team;

  const EditTeamScreen({
    super.key,
    required this.team,
  });

  @override
  State<EditTeamScreen> createState() =>
      _EditTeamScreenState();
}

class _EditTeamScreenState
    extends State<EditTeamScreen> {
  late final TextEditingController
      _teamNameController;

  late String _division;

  Coach? _selectedCoach;

  @override
  void initState() {
    super.initState();

    _teamNameController =
        TextEditingController(
      text: widget.team.name,
    );

    _division = widget.team.division;

    if (widget.team.coachId.isNotEmpty) {
      try {
        _selectedCoach =
            CoachDataService.coaches.firstWhere(
          (coach) =>
              coach.id ==
              widget.team.coachId,
        );
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  Future<void> _saveTeam() async {
    final updatedTeam = Team(
      id: widget.team.id,
      name: _teamNameController.text,
      division: _division,
      coachId:
          _selectedCoach?.id ?? '',
      coachName:
          _selectedCoach?.fullName ??
          '',
    );

    await TeamDataService.updateTeam(
      updatedTeam,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final availableCoaches =
        CoachDataService.coaches.where(
      (coach) {
        if (coach.id ==
            widget.team.coachId) {
          return true;
        }

        return coach.isActive &&
            !TeamDataService
                .isCoachAssigned(
              coach.id,
            );
      },
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Team',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:
                  _teamNameController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Team Name',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownButtonFormField<
                String>(
              initialValue:
                  _division,
              items: const [
                DropdownMenuItem(
                  value: 'U6',
                  child: Text('U6'),
                ),
                DropdownMenuItem(
                  value: 'U8',
                  child: Text('U8'),
                ),
                DropdownMenuItem(
                  value: 'U10',
                  child: Text('U10'),
                ),
                DropdownMenuItem(
                  value: 'U12',
                  child: Text('U12'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _division =
                      value!;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownButtonFormField<
                Coach>(
              initialValue:
                  _selectedCoach,
              decoration:
                  const InputDecoration(
                labelText:
                    'Coach',
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
                  'Save Changes',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}