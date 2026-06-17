import '../models/announcement.dart';
import 'storage_service.dart';

class AnnouncementDataService {
  static List<Announcement> announcements = [];

  static Future<void> loadAnnouncements() async {
    final box = StorageService.getAnnouncementsBox();

    announcements = box.values.map((item) {
      final data = Map<String, dynamic>.from(item);

      return Announcement(
        id: data['id'],
        title: data['title'],
        message: data['message'],
        isActive: data['isActive'],
      );
    }).toList();
  }

  static Future<void> saveAnnouncements() async {
    final box = StorageService.getAnnouncementsBox();

    await box.clear();

    for (final announcement in announcements) {
      await box.add({
        'id': announcement.id,
        'title': announcement.title,
        'message': announcement.message,
        'isActive': announcement.isActive,
      });
    }
  }

  static Future<void> addAnnouncement(
    Announcement announcement,
  ) async {
    announcements = announcements
        .map(
          (a) => Announcement(
            id: a.id,
            title: a.title,
            message: a.message,
            isActive: false,
          ),
        )
        .toList();

    announcements.add(announcement);

    await saveAnnouncements();
  }

  static Future<void> setActiveAnnouncement(
    String id,
  ) async {
    announcements = announcements
        .map(
          (a) => Announcement(
            id: a.id,
            title: a.title,
            message: a.message,
            isActive: a.id == id,
          ),
        )
        .toList();

    await saveAnnouncements();
  }

  static Future<void> deactivateAnnouncement(
    String id,
  ) async {
    announcements = announcements
        .map(
          (a) => Announcement(
            id: a.id,
            title: a.title,
            message: a.message,
            isActive: a.id == id
                ? false
                : a.isActive,
          ),
        )
        .toList();

    await saveAnnouncements();
  }

  static Future<void> updateAnnouncement(
    Announcement updated,
  ) async {
    announcements = announcements
        .map(
          (a) => a.id == updated.id
              ? updated
              : a,
        )
        .toList();

    await saveAnnouncements();
  }

  static Future<void> deleteAnnouncement(
    String id,
  ) async {
    announcements.removeWhere(
      (a) => a.id == id,
    );

    await saveAnnouncements();
  }

  static Announcement?
      getActiveAnnouncement() {
    try {
      return announcements.firstWhere(
        (a) => a.isActive,
      );
    } catch (_) {
      return null;
    }
  }
}