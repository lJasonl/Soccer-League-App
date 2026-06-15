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