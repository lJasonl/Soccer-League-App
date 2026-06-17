import 'package:flutter/material.dart';

import '../../models/announcement.dart';
import '../../services/announcement_data_service.dart';

class AnnouncementManagementScreen
    extends StatefulWidget {
  const AnnouncementManagementScreen({
    super.key,
  });

  @override
  State<AnnouncementManagementScreen>
      createState() =>
          _AnnouncementManagementScreenState();
}

class _AnnouncementManagementScreenState
    extends State<
        AnnouncementManagementScreen> {
  final _titleController =
      TextEditingController();

  final _messageController =
      TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleController.text
            .trim()
            .isEmpty ||
        _messageController.text
            .trim()
            .isEmpty) {
      return;
    }

    await AnnouncementDataService
        .addAnnouncement(
      Announcement(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        title:
            _titleController.text
                .trim(),
        message:
            _messageController.text
                .trim(),
        isActive: true,
      ),
    );

    if (!mounted) return;

    _titleController.clear();
    _messageController.clear();

    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Announcement saved.',
        ),
      ),
    );
  }

  Future<void> _editAnnouncement(
    Announcement announcement,
  ) async {
    final titleController =
        TextEditingController(
      text: announcement.title,
    );

    final messageController =
        TextEditingController(
      text: announcement.message,
    );

    final result =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Announcement',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                TextField(
                  controller:
                      titleController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Title',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller:
                      messageController,
                  maxLines: 4,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Message',
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
              child: const Text(
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
              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );

    if (result != true) {
      return;
    }

    await AnnouncementDataService
        .updateAnnouncement(
      Announcement(
        id: announcement.id,
        title: titleController.text
            .trim(),
        message:
            messageController.text
                .trim(),
        isActive:
            announcement.isActive,
      ),
    );

    setState(() {});
  }

  Future<void> _deleteAnnouncement(
    Announcement announcement,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Announcement?',
          ),
          content: const Text(
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
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
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await AnnouncementDataService
        .deleteAnnouncement(
      announcement.id,
    );

    setState(() {});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Announcements',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Create Announcement',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller:
                  _titleController,
              decoration:
                  const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller:
                  _messageController,
              maxLines: 3,
              decoration:
                  const InputDecoration(
                labelText:
                    'Message',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: _save,
              child: const Text(
                'Save Announcement',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Announcements',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ...AnnouncementDataService
                .announcements
                .map(
                  (announcement) =>
                      Card(
                    child: ListTile(
                      title: Text(
                        announcement
                            .title,
                      ),
                      subtitle: Text(
                        announcement
                            .message,
                      ),
                      trailing:
                          PopupMenuButton<
                              String>(
                        onSelected:
                            (
                          value,
                        ) async {
                          switch (
                              value) {
                            case 'edit':
                              await _editAnnouncement(
                                announcement,
                              );
                              break;

                            case 'activate':
                              await AnnouncementDataService
                                  .setActiveAnnouncement(
                                announcement
                                    .id,
                              );
                              setState(
                                () {},
                              );
                              break;

                            case 'deactivate':
                              await AnnouncementDataService
                                  .deactivateAnnouncement(
                                announcement
                                    .id,
                              );
                              setState(
                                () {},
                              );
                              break;

                            case 'delete':
                              await _deleteAnnouncement(
                                announcement,
                              );
                              break;
                          }
                        },
                        itemBuilder:
                            (
                          context,
                        ) =>
                            [
                          const PopupMenuItem(
                            value:
                                'edit',
                            child: Text(
                              'Edit Announcement',
                            ),
                          ),
                          PopupMenuItem(
                            value: announcement
                                    .isActive
                                ? 'deactivate'
                                : 'activate',
                            child: Text(
                              announcement
                                      .isActive
                                  ? 'Deactivate'
                                  : 'Set Active',
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
                      leading:
                          announcement
                                  .isActive
                              ? const Chip(
                                  label:
                                      Text(
                                    'Active',
                                  ),
                                )
                              : null,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}