import 'package:flutter/material.dart';

import '../../models/referee.dart';
import '../../services/referee_data_service.dart';

class RefereeScreen
    extends StatefulWidget {
  const RefereeScreen({
    super.key,
  });

  @override
  State<RefereeScreen> createState() =>
      _RefereeScreenState();
}

class _RefereeScreenState
    extends State<RefereeScreen> {
  Future<void> _addReferee() async {
    final firstNameController =
        TextEditingController();

    final lastNameController =
        TextEditingController();

    final emailController =
        TextEditingController();

    final phoneController =
        TextEditingController();

    final result =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Referee',
          ),
          content:
              SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                TextField(
                  controller:
                      firstNameController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'First Name',
                  ),
                ),
                TextField(
                  controller:
                      lastNameController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Last Name',
                  ),
                ),
                TextField(
                  controller:
                      emailController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Email',
                  ),
                ),
                TextField(
                  controller:
                      phoneController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Phone',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child:
                  const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child:
                  const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result != true) {
      return;
    }

    await RefereeDataService
        .addReferee(
      Referee(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        firstName:
            firstNameController.text,
        lastName:
            lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        isActive: true,
        createdAt: DateTime.now(),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final referees =
        RefereeDataService.referees;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Referees'),
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: _addReferee,
        child:
            const Icon(Icons.add),
      ),
      body: referees.isEmpty
          ? const Center(
              child: Text(
                'No referees added.',
              ),
            )
          : ListView.builder(
              itemCount:
                  referees.length,
              itemBuilder:
                  (context, index) {
                final referee =
                    referees[index];

                return ListTile(
                  title: Text(
                    referee.fullName,
                  ),
                  subtitle: Text(
                    referee.email,
                  ),
                );
              },
            ),
    );
  }
}