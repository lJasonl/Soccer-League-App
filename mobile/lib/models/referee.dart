class Referee {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final bool isActive;
  final DateTime createdAt;

  Referee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.isActive,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  Referee copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Referee(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}