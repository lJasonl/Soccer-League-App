class VolunteerEntry {
  final String id;
  final String familyId;
  final DateTime dateWorked;
  final double hoursWorked;
  final String activityType;
  final String notes;

  const VolunteerEntry({
    required this.id,
    required this.familyId,
    required this.dateWorked,
    required this.hoursWorked,
    required this.activityType,
    required this.notes,
  });
}