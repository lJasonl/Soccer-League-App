class ScholarshipFamily {
  final String id;
  final String familyName;
  final String primaryContact;
  final int hoursRequired;
  final int hoursCompleted;
  final String notes;
  final bool isActive;

  const ScholarshipFamily({
    required this.id,
    required this.familyName,
    required this.primaryContact,
    required this.hoursRequired,
    required this.hoursCompleted,
    required this.notes,
    required this.isActive,
  });

  int get hoursRemaining {
    final remaining =
        hoursRequired - hoursCompleted;

    return remaining < 0
        ? 0
        : remaining;
  }
}