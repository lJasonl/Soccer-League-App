import 'package:flutter/material.dart';

import '../../models/player.dart';
import '../../models/registration.dart';
import '../../models/team.dart';
import '../../services/player_data_service.dart';
import '../../services/registration_data_service.dart';
import 'select_team_screen.dart';

class RegistrationDetailsScreen extends StatefulWidget {
  final Registration registration;

  const RegistrationDetailsScreen({
    super.key,
    required this.registration,
  });

  @override
  State<RegistrationDetailsScreen> createState() =>
      _RegistrationDetailsScreenState();
}

class _RegistrationDetailsScreenState
    extends State<RegistrationDetailsScreen> {
  Future<void> _approveRegistration() async {
    final Team? selectedTeam =
        await Navigator.push<Team>(
      context,
      MaterialPageRoute(
        builder: (_) => const SelectTeamScreen(),
      ),
    );

    if (selectedTeam == null) {
      return;
    }

    final player = Player(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      teamId: selectedTeam.id,
      firstName: widget.registration.firstName,
      lastName: widget.registration.lastName,
      jerseyNumber: 0,
      birthYear: widget.registration.birthYear,
      parentName: widget.registration.parentName,
      parentPhone: widget.registration.parentPhone,
      registrationStatus:
          Registration.approved,
    );

    await PlayerDataService.addPlayer(
      player,
    );

    final updated = Registration(
      id: widget.registration.id,
      firstName: widget.registration.firstName,
      lastName: widget.registration.lastName,
      birthYear: widget.registration.birthYear,
      parentName: widget.registration.parentName,
      parentPhone: widget.registration.parentPhone,
      parentEmail: widget.registration.parentEmail,
      emergencyContact:
          widget.registration.emergencyContact,
      emergencyPhone:
          widget.registration.emergencyPhone,
      medicalNotes:
          widget.registration.medicalNotes,
      registrationNotes:
          widget.registration.registrationNotes,
      division: widget.registration.division,
      status: Registration.approved,
      registrationDate:
          widget.registration.registrationDate,
    );

    await RegistrationDataService
        .updateRegistration(updated);

    if (!mounted) return;

    Navigator.pop(context);
  }

  Future<void> _updateStatus(
    String status,
  ) async {
    final updated = Registration(
      id: widget.registration.id,
      firstName: widget.registration.firstName,
      lastName: widget.registration.lastName,
      birthYear: widget.registration.birthYear,
      parentName: widget.registration.parentName,
      parentPhone: widget.registration.parentPhone,
      parentEmail: widget.registration.parentEmail,
      emergencyContact:
          widget.registration.emergencyContact,
      emergencyPhone:
          widget.registration.emergencyPhone,
      medicalNotes:
          widget.registration.medicalNotes,
      registrationNotes:
          widget.registration.registrationNotes,
      division: widget.registration.division,
      status: status,
      registrationDate:
          widget.registration.registrationDate,
    );

    await RegistrationDataService
        .updateRegistration(updated);

    if (!mounted) return;

    Navigator.pop(context);
  }

  Future<void> _deleteRegistration() async {
    await RegistrationDataService
        .deleteRegistration(
      widget.registration.id,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final registration = widget.registration;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              registration.fullName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Birth Year: ${registration.birthYear}',
            ),
            const SizedBox(height: 12),
            Text(
              'Parent: ${registration.parentName}',
            ),
            Text(
              'Parent Phone: ${registration.parentPhone}',
            ),
            Text(
              'Parent Email: ${registration.parentEmail}',
            ),
            const SizedBox(height: 12),
            Text(
              'Emergency Contact: ${registration.emergencyContact}',
            ),
            Text(
              'Emergency Phone: ${registration.emergencyPhone}',
            ),
            const SizedBox(height: 12),
            Text(
              'Division: ${registration.division}',
            ),
            Text(
              'Status: ${registration.status}',
            ),
            Text(
              'Registered: ${registration.registrationDate}',
            ),
            const SizedBox(height: 12),
            const Text(
              'Medical Notes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              registration.medicalNotes.isEmpty
                  ? 'None'
                  : registration.medicalNotes,
            ),
            const SizedBox(height: 12),
            const Text(
              'Registration Notes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              registration.registrationNotes.isEmpty
                  ? 'None'
                  : registration.registrationNotes,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  _approveRegistration,
              child: const Text(
                'Approve & Assign Team',
              ),
            ),
            ElevatedButton(
              onPressed: () => _updateStatus(
                Registration.waitlisted,
              ),
              child: const Text(
                'Waitlist',
              ),
            ),
            ElevatedButton(
              onPressed: () => _updateStatus(
                Registration.rejected,
              ),
              child: const Text(
                'Reject',
              ),
            ),
            ElevatedButton(
              onPressed:
                  _deleteRegistration,
              child: const Text(
                'Delete',
              ),
            ),
          ],
        ),
      ),
    );
  }
}