import 'package:flutter/material.dart';

import '../../services/registration_data_service.dart';
import 'add_registration_screen.dart';
import 'registration_details_screen.dart';

class RegistrationsScreen extends StatefulWidget {
  const RegistrationsScreen({super.key});

  @override
  State<RegistrationsScreen> createState() =>
      _RegistrationsScreenState();
}

class _RegistrationsScreenState
    extends State<RegistrationsScreen> {
  @override
  Widget build(BuildContext context) {
    final registrations =
        RegistrationDataService.registrations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrations'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddRegistrationScreen(),
            ),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: registrations.isEmpty
          ? const Center(
              child: Text(
                'No registrations found.',
              ),
            )
          : ListView.builder(
              itemCount: registrations.length,
              itemBuilder: (context, index) {
                final registration =
                    registrations[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      registration.fullName,
                    ),
                    subtitle: Text(
                      '${registration.division} • ${registration.status}',
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RegistrationDetailsScreen(
                            registration:
                                registration,
                          ),
                        ),
                      );

                      setState(() {});
                    },
                  ),
                );
              },
            ),
    );
  }
}