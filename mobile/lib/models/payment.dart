class Payment {
  final String id;
  final String playerId;
  final String playerName;
  final double amount;
  final String paymentDate;
  final String paymentMethod;

  const Payment({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
  });
}