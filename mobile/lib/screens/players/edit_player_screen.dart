import 'package:flutter/material.dart';

import '../../models/player.dart';

class EditPlayerScreen extends StatefulWidget {
  final Player player;

  const EditPlayerScreen({
    super.key,
    required this.player,
  });

  @override
  State<EditPlayerScreen> createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends State<EditPlayerScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _jerseyNumberController;
  late final TextEditingController _birthYearController;
  late final TextEditingController _parentNameController;
  late final TextEditingController _parentPhoneController;

  late String _registrationStatus;

  @override
  void initState() {
    super.initState();

    _firstNameController =
        TextEditingController(text: widget.player.firstName);

    _lastNameController =
        TextEditingController(text: widget.player.lastName);

    _jerseyNumberController =
        TextEditingController(
          text: widget.player.jerseyNumber.toString(),
        );

    _birthYearController =
        TextEditingController(
          text: widget.player.birthYear.toString(),
        );

    _parentNameController =
        TextEditingController(
          text: widget.player.parentName,
        );

    _parentPhoneController =
        TextEditingController(
          text: widget.player.parentPhone,
        );

    _registrationStatus =
        widget.player.registrationStatus;
  }

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

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit functionality coming next'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Player'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _jerseyNumberController,
              decoration: const InputDecoration(
                labelText: 'Jersey Number',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _birthYearController,
              decoration: const InputDecoration(
                labelText: 'Birth Year',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _parentNameController,
              decoration: const InputDecoration(
                labelText: 'Parent Name',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _parentPhoneController,
              decoration: const InputDecoration(
                labelText: 'Parent Phone',
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _registrationStatus,
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
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}