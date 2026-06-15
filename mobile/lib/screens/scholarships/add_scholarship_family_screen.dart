import 'package:flutter/material.dart';

import '../../models/scholarship_family.dart';
import '../../services/scholarship_data_service.dart';

class AddScholarshipFamilyScreen
    extends StatefulWidget {
  const AddScholarshipFamilyScreen({
    super.key,
  });

  @override
  State<AddScholarshipFamilyScreen>
      createState() =>
          _AddScholarshipFamilyScreenState();
}

class _AddScholarshipFamilyScreenState
    extends State<
        AddScholarshipFamilyScreen> {
  final _formKey =
      GlobalKey<FormState>();

  final _familyNameController =
      TextEditingController();

  final _primaryContactController =
      TextEditingController();

  final _hoursRequiredController =
      TextEditingController(
    text: '20',
  );

  final _notesController =
      TextEditingController();

  @override
  void dispose() {
    _familyNameController.dispose();
    _primaryContactController.dispose();
    _hoursRequiredController.dispose();
    _notesController.dispose();

    super.dispose();
  }

  Future<void> _saveFamily() async {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    final family =
        ScholarshipFamily(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      familyName:
          _familyNameController.text
              .trim(),
      primaryContact:
          _primaryContactController
              .text
              .trim(),
      hoursRequired:
          int.tryParse(
                _hoursRequiredController
                    .text,
              ) ??
              0,
      hoursCompleted: 0,
      notes:
          _notesController.text.trim(),
      isActive: true,
    );

    await ScholarshipDataService
        .addFamily(
      family,
    );

    if (!mounted) return;

    Navigator.pop(
      context,
      true,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Scholarship Family',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding:
              const EdgeInsets.all(
            16,
          ),
          children: [
            TextFormField(
              controller:
                  _familyNameController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Family Name',
              ),
              validator: (value) {
                if (value == null ||
                    value
                        .trim()
                        .isEmpty) {
                  return 'Family name is required';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller:
                  _primaryContactController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Primary Contact',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller:
                  _hoursRequiredController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Hours Required',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller:
                  _notesController,
              maxLines: 4,
              decoration:
                  const InputDecoration(
                labelText:
                    'Notes',
                alignLabelWithHint:
                    true,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton.icon(
              onPressed:
                  _saveFamily,
              icon: const Icon(
                Icons.save,
              ),
              label: const Text(
                'Save Family',
              ),
            ),
          ],
        ),
      ),
    );
  }
}