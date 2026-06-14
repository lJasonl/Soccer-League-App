import '../data/sample_registrations.dart';
import '../models/registration.dart';
import 'storage_service.dart';

class RegistrationDataService {
  static List<Registration> registrations =
      List.from(sampleRegistrations);

  static Future<void> loadRegistrations() async {
    final box = StorageService.getRegistrationsBox();

    if (box.isEmpty) {
      return;
    }

    registrations = box.values.map((item) {
      final data = Map<String, dynamic>.from(item);

      return Registration(
        id: data['id'],
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        birthYear: data['birthYear'] ?? 0,
        parentName: data['parentName'] ?? '',
        parentPhone: data['parentPhone'] ?? '',
        parentEmail: data['parentEmail'] ?? '',
        emergencyContact:
            data['emergencyContact'] ?? '',
        emergencyPhone:
            data['emergencyPhone'] ?? '',
        medicalNotes:
            data['medicalNotes'] ?? '',
        registrationNotes:
            data['registrationNotes'] ?? '',
        division: data['division'] ?? '',
        status: data['status'] ?? '',
        registrationDate:
            data['registrationDate'] ?? '',
      );
    }).toList();
  }

  static Future<void> saveRegistrations() async {
    final box = StorageService.getRegistrationsBox();

    await box.clear();

    for (final registration in registrations) {
      await box.add({
        'id': registration.id,
        'firstName': registration.firstName,
        'lastName': registration.lastName,
        'birthYear': registration.birthYear,
        'parentName': registration.parentName,
        'parentPhone': registration.parentPhone,
        'parentEmail': registration.parentEmail,
        'emergencyContact':
            registration.emergencyContact,
        'emergencyPhone':
            registration.emergencyPhone,
        'medicalNotes':
            registration.medicalNotes,
        'registrationNotes':
            registration.registrationNotes,
        'division': registration.division,
        'status': registration.status,
        'registrationDate':
            registration.registrationDate,
      });
    }
  }

  static Future<void> addRegistration(
    Registration registration,
  ) async {
    registrations.add(registration);

    await saveRegistrations();
  }

  static Future<void> updateRegistration(
    Registration registration,
  ) async {
    final index = registrations.indexWhere(
      (item) => item.id == registration.id,
    );

    if (index != -1) {
      registrations[index] = registration;

      await saveRegistrations();
    }
  }

  static Future<void> deleteRegistration(
    String registrationId,
  ) async {
    registrations.removeWhere(
      (item) => item.id == registrationId,
    );

    await saveRegistrations();
  }
}