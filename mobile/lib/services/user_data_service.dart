import '../models/user.dart';
import 'storage_service.dart';

class UserDataService {
  static List<AppUser> users = [];

  static Future<void> loadUsers() async {
    final box = StorageService.getUsersBox();

    if (box.isEmpty) {
      users = [
        AppUser(
          id: '1',
          name: 'League Admin',
          email: 'admin@league.com',
          role: 'Admin',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        AppUser(
          id: '2',
          name: 'Coach Smith',
          email: 'coach@league.com',
          role: 'Coach',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        AppUser(
          id: '3',
          name: 'Referee Jones',
          email: 'referee@league.com',
          role: 'Referee',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        AppUser(
          id: '4',
          name: 'Parent User',
          email: 'parent@league.com',
          role: 'Parent',
          isActive: true,
          createdAt: DateTime.now(),
        ),
      ];

      await saveUsers();
      return;
    }

    users = box.values.map((item) {
      final data =
          Map<String, dynamic>.from(
        item,
      );

      return AppUser(
        id: data['id'] ?? '',
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        role: data['role'] ?? 'Parent',
        isActive:
            data['isActive'] ?? true,
        createdAt:
            DateTime.tryParse(
                  data['createdAt'] ??
                      '',
                ) ??
                DateTime.now(),
      );
    }).toList();
  }

  static Future<void> saveUsers()
      async {
    final box =
        StorageService.getUsersBox();

    await box.clear();

    for (final user in users) {
      await box.add({
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'role': user.role,
        'isActive':
            user.isActive,
        'createdAt': user
            .createdAt
            .toIso8601String(),
      });
    }
  }

  static Future<void> addUser(
    AppUser user,
  ) async {
    users.add(user);

    await saveUsers();
  }

  static Future<void> updateUser(
    AppUser user,
  ) async {
    final index =
        users.indexWhere(
      (u) => u.id == user.id,
    );

    if (index != -1) {
      users[index] = user;

      await saveUsers();
    }
  }

  static Future<void> deleteUser(
    String userId,
  ) async {
    users.removeWhere(
      (u) => u.id == userId,
    );

    await saveUsers();
  }
}