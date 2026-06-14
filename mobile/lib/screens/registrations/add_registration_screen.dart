import 'package:flutter/material.dart';

import '../../models/registration.dart';
import '../../services/registration_data_service.dart';

class AddRegistrationScreen
    extends StatefulWidget {
  const AddRegistrationScreen({
    super.key,
  });

  @override
  State<AddRegistrationScreen>
      createState() =>
          _AddRegistrationScreenState();
}

class _AddRegistrationScreenState
    extends State<AddRegistrationScreen> {
  final _firstNameController =
      TextEditingController();

  final _lastNameController =
      TextEditingController();

  final _birthYearController =
      TextEditingController();

  final _parentNameController =
      TextEditingController();

  final _parentPhoneController =
      TextEditingController();

  final _parentEmailController =
      TextEditingController();

  final _emergencyContactController =
      TextEditingController();

  final _emergencyPhoneController =
      TextEditingController();

  final _medicalNotesController =
      TextEditingController();

  final _registrationNotesController =
      TextEditingController();

  final _divisionController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthYearController.dispose();
    _parentNameController.dispose();
    _parentPhoneController.dispose();
    _parentEmailController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    _medicalNotesController.dispose();
    _registrationNotesController.dispose();
    _divisionController.dispose();
    super.dispose();
  }

  Future<void> _saveRegistration() async {
    if (_firstNameController.text
            .trim()
            .isEmpty ||
        _lastNameController.text
            .trim()
            .isEmpty) {
      return;
    }

    final registration = Registration(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      firstName:
          _firstNameController.text.trim(),
      lastName:
          _lastNameController.text.trim(),
      birthYear:
          int.tryParse(
            _birthYearController.text,
          ) ??
          0,
      parentName:
          _parentNameController.text.trim(),
      parentPhone:
          _parentPhoneController.text.trim(),
      parentEmail:
          _parentEmailController.text.trim(),
      emergencyContact:
          _emergencyContactController.text
              .trim(),
      emergencyPhone:
          _emergencyPhoneController.text
              .trim(),
      medicalNotes:
          _medicalNotesController.text.trim(),
      registrationNotes:
          _registrationNotesController.text
              .trim(),
      division:
          _divisionController.text.trim(),
      status: Registration.pending,
      registrationDate:
          DateTime.now()
              .toString()
              .split(' ')
              .first,
    );

    await RegistrationDataService
        .addRegistration(
      registration,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Add Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller:
                  _firstNameController,
              decoration:
                  const InputDecoration(
                labelText: 'First Name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _lastNameController,
              decoration:
                  const InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _birthYearController,
              decoration:
                  const InputDecoration(
                labelText: 'Birth Year',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _parentNameController,
              decoration:
                  const InputDecoration(
                labelText: 'Parent Name',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _parentPhoneController,
              decoration:
                  const InputDecoration(
                labelText: 'Parent Phone',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _parentEmailController,
              decoration:
                  const InputDecoration(
                labelText: 'Parent Email',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _emergencyContactController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Emergency Contact',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _emergencyPhoneController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Emergency Phone',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _divisionController,
              decoration:
                  const InputDecoration(
                labelText: 'Division',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _medicalNotesController,
              maxLines: 3,
              decoration:
                  const InputDecoration(
                labelText:
                    'Medical Notes',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:
                  _registrationNotesController,
              maxLines: 3,
              decoration:
                  const InputDecoration(
                labelText:
                    'Registration Notes',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  _saveRegistration,
              child:
                  const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}