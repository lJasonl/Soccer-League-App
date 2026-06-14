class Registration {
  static const String pending = 'Pending';
  static const String approved = 'Approved';
  static const String waitlisted = 'Waitlisted';
  static const String rejected = 'Rejected';

  final String id;

  final String firstName;
  final String lastName;
  final int birthYear;

  final String parentName;
  final String parentPhone;
  final String parentEmail;

  final String emergencyContact;
  final String emergencyPhone;

  final String medicalNotes;
  final String registrationNotes;

  final String division;
  final String status;
  final String registrationDate;

  const Registration({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthYear,
    required this.parentName,
    required this.parentPhone,
    required this.parentEmail,
    required this.emergencyContact,
    required this.emergencyPhone,
    required this.medicalNotes,
    required this.registrationNotes,
    required this.division,
    required this.status,
    required this.registrationDate,
  });

  String get fullName =>
      '$firstName $lastName';
}