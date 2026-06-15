import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/user_data_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    super.key,
  });

  @override
  State<UserScreen> createState() =>
      _UserScreenState();
}

class _UserScreenState
    extends State<UserScreen> {
  Future<void> _addUser() async {
    final nameController =
        TextEditingController();

    final emailController =
        TextEditingController();

    String role = 'Parent';

    final result =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Add User',
              ),
              content:
                  SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    TextField(
                      controller:
                          nameController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Name',
                      ),
                    ),
                    const SizedBox(
                      height: 12,
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
                    const SizedBox(
                      height: 12,
                    ),
                    DropdownButtonFormField<
                        String>(
                      initialValue:
                          role,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Role',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value:
                              'Admin',
                          child: Text(
                            'Admin',
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              'Coach',
                          child: Text(
                            'Coach',
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              'Referee',
                          child: Text(
                            'Referee',
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              'Parent',
                          child: Text(
                            'Parent',
                          ),
                        ),
                      ],
                      onChanged: (
                        value,
                      ) {
                        setDialogState(
                          () {
                            role =
                                value!;
                          },
                        );
                      },
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
                      const Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      true,
                    );
                  },
                  child:
                      const Text(
                    'Save',
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != true) {
      return;
    }

    await UserDataService.addUser(
      AppUser(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        name:
            nameController.text,
        email:
            emailController.text,
        role: role,
        isActive: true,
        createdAt:
            DateTime.now(),
      ),
    );

    setState(() {});
  }

  Future<void> _toggleUser(
    AppUser user,
  ) async {
    await UserDataService
        .updateUser(
      user.copyWith(
        isActive:
            !user.isActive,
      ),
    );

    setState(() {});
  }

  Future<void> _deleteUser(
    AppUser user,
  ) async {
    await UserDataService
        .deleteUser(user.id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final users =
        UserDataService.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Roles',
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: _addUser,
        child:
            const Icon(Icons.add),
      ),
      body: users.isEmpty
          ? const Center(
              child: Text(
                'No users added.',
              ),
            )
          : ListView.builder(
              itemCount:
                  users.length,
              itemBuilder:
                  (context, index) {
                final user =
                    users[index];

                return Card(
                  margin:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      user.name,
                    ),
                    subtitle: Text(
                      '${user.role} • ${user.email}',
                    ),
                    trailing:
                        PopupMenuButton<
                            String>(
                      onSelected:
                          (value) {
                        if (value ==
                            'status') {
                          _toggleUser(
                            user,
                          );
                        }

                        if (value ==
                            'delete') {
                          _deleteUser(
                            user,
                          );
                        }
                      },
                      itemBuilder:
                          (context) => [
                        PopupMenuItem(
                          value:
                              'status',
                          child: Text(
                            user.isActive
                                ? 'Deactivate'
                                : 'Activate',
                          ),
                        ),
                        const PopupMenuItem(
                          value:
                              'delete',
                          child: Text(
                            'Delete',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}