import 'package:flutter/material.dart';

import '../../models/scholarship_family.dart';
import '../../models/volunteer_entry.dart';
import '../../services/volunteer_data_service.dart';

class AddVolunteerHoursScreen
    extends StatefulWidget {
  final ScholarshipFamily family;

  const AddVolunteerHoursScreen({
    super.key,
    required this.family,
  });

  @override
  State<AddVolunteerHoursScreen>
      createState() =>
          _AddVolunteerHoursScreenState();
}

class _AddVolunteerHoursScreenState
    extends State<
        AddVolunteerHoursScreen> {
  final _formKey =
      GlobalKey<FormState>();

  final _hoursController =
      TextEditingController();

  final _notesController =
      TextEditingController();

  String _activity =
      'Concessions';

  final List<String> activities = [
    'Concessions',
    'Field Maintenance',
    'Field Painting',
    'Tournament Setup',
    'Fundraising',
    'Team Manager',
    'Equipment Distribution',
    'Other',
  ];

  @override
  void dispose() {
    _hoursController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    await VolunteerDataService
        .addEntry(
      VolunteerEntry(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        familyId:
            widget.family.id,
        dateWorked:
            DateTime.now(),
        hoursWorked:
            double.parse(
          _hoursController.text,
        ),
        activityType:
            _activity,
        notes:
            _notesController.text
                .trim(),
      ),
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
          'Add Volunteer Hours',
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
            DropdownButtonFormField<
                String>(
              value: _activity,
              decoration:
                  const InputDecoration(
                labelText:
                    'Activity Type',
              ),
              items: activities
                  .map(
                    (activity) =>
                        DropdownMenuItem(
                      value: activity,
                      child: Text(
                        activity,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _activity =
                        value;
                  });
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller:
                  _hoursController,
              keyboardType:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText:
                    'Hours Worked',
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Enter hours worked';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller:
                  _notesController,
              maxLines: 3,
              decoration:
                  const InputDecoration(
                labelText:
                    'Notes',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(
                Icons.save,
              ),
              label: const Text(
                'Save Hours',
              ),
            ),
          ],
        ),
      ),
    );
  }
}