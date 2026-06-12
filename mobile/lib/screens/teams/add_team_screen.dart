import 'package:flutter/material.dart';

import '../../models/team.dart';
import '../../services/team_data_service.dart';

class AddTeamScreen extends StatefulWidget {
  const AddTeamScreen({super.key});

  @override
  State<AddTeamScreen> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  final _formKey = GlobalKey<FormState>();

  final _teamNameController = TextEditingController();
  final _coachController = TextEditingController();

  String _division = 'U6';

  @override
  void dispose() {
    _teamNameController.dispose();
    _coachController.dispose();
    super.dispose();
  }

  void _saveTeam() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final team = Team(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _teamNameController.text,
      division: _division,
      coach: _coachController.text,
    );

    TeamDataService.addTeam(team);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Team'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _teamNameController,
                decoration: const InputDecoration(
                  labelText: 'Team Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter team name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _division,
                decoration: const InputDecoration(
                  labelText: 'Division',
                  border: OutlineInputBorder(),
                ),
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

              TextFormField(
                controller: _coachController,
                decoration: const InputDecoration(
                  labelText: 'Coach Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTeam,
                  child: const Text('Save Team'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}