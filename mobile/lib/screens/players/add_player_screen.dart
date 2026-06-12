import 'package:flutter/material.dart';

import '../../models/player.dart';
import '../../services/league_data_service.dart';

class AddPlayerScreen extends StatefulWidget {
  final String teamId;

  const AddPlayerScreen({
    super.key,
    required this.teamId,
  });

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _jerseyNumberController = TextEditingController();
  final _birthYearController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _parentPhoneController = TextEditingController();

  String _registrationStatus = 'Active';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _jerseyNumberController.dispose();
    _birthYearController.dispose();
    _parentNameController.dispose();
    _parentPhoneController.dispose();
    super.dispose();
  }

  void _savePlayer() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final player = Player(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      teamId: widget.teamId,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      jerseyNumber: int.tryParse(
            _jerseyNumberController.text,
          ) ??
          0,
      birthYear: int.tryParse(
            _birthYearController.text,
          ) ??
          0,
      parentName: _parentNameController.text,
      parentPhone: _parentPhoneController.text,
      registrationStatus: _registrationStatus,
    );

    LeagueDataService.addPlayer(player);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Player'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter first name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter last name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _jerseyNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jersey Number',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _birthYearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Birth Year',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _parentNameController,
                decoration: const InputDecoration(
                  labelText: 'Parent / Guardian Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _parentPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Parent Phone',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _registrationStatus,
                decoration: const InputDecoration(
                  labelText: 'Registration Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Active',
                    child: Text('Active'),
                  ),
                  DropdownMenuItem(
                    value: 'Pending',
                    child: Text('Pending'),
                  ),
                  DropdownMenuItem(
                    value: 'Inactive',
                    child: Text('Inactive'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _registrationStatus = value!;
                  });
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _savePlayer,
                  child: const Text('Save Player'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}