import 'package:flutter/material.dart';

import '../../models/team.dart';
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

  late final TextEditingController
      _coachController;

  late String _division;

  @override
  void initState() {
    super.initState();

    _teamNameController =
        TextEditingController(
      text: widget.team.name,
    );

    _coachController =
        TextEditingController(
      text: widget.team.coach,
    );

    _division = widget.team.division;
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _coachController.dispose();
    super.dispose();
  }

  void _saveTeam() {
    final updatedTeam = Team(
      id: widget.team.id,
      name: _teamNameController.text,
      division: _division,
      coach: _coachController.text,
    );

    TeamDataService.updateTeam(updatedTeam);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _teamNameController,
              decoration:
                  const InputDecoration(
                labelText: 'Team Name',
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _division,
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
                  _division = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _coachController,
              decoration:
                  const InputDecoration(
                labelText: 'Coach Name',
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTeam,
                child:
                    const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}