import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/session_service.dart';
import '../../services/user_data_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  AppUser? _selectedUser;

  @override
  Widget build(BuildContext context) {
    final users =
        UserDataService.users
            .where(
              (user) => user.isActive,
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(
          24,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .stretch,
          children: [
            const Text(
              'Select User',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            Expanded(
              child: users.isEmpty
                  ? const Center(
                      child: Text(
                        'No active users available.',
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          users.length,
                      itemBuilder:
                          (
                        context,
                        index,
                      ) {
                        final user =
                            users[index];

                        return RadioListTile<
                            AppUser>(
                          value: user,
                          groupValue:
                              _selectedUser,
                          title: Text(
                            user.name,
                          ),
                          subtitle: Text(
                            '${user.role} • ${user.email}',
                          ),
                          onChanged:
                              (
                            value,
                          ) {
                            setState(
                              () {
                                _selectedUser =
                                    value;
                              },
                            );
                          },
                        );
                      },
                    ),
            ),

            const SizedBox(
              height: 16,
            ),

            SizedBox(
              height: 52,
              child:
                  ElevatedButton(
                onPressed:
                    _selectedUser ==
                            null
                        ? null
                        : () async {
                            await SessionService
                                .setCurrentUserId(
                              _selectedUser!
                                  .id,
                            );

                            if (!context
                                .mounted) {
                              return;
                            }

                            Navigator.pushReplacementNamed(
                              context,
                              '/dashboard',
                            );
                          },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}