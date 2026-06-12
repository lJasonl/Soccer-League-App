class Player {
  final String id;
  final String teamId;

  final String firstName;
  final String lastName;

  final int jerseyNumber;
  final int birthYear;

  final String parentName;
  final String parentPhone;

  final String registrationStatus;

  const Player({
    required this.id,
    required this.teamId,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.birthYear,
    required this.parentName,
    required this.parentPhone,
    required this.registrationStatus,
  });

  String get fullName => '$firstName $lastName';
}