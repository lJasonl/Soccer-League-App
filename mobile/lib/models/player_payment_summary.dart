class PlayerPaymentSummary {
  final String playerId;
  final String playerName;
  final double registrationFee;
  final double amountPaid;

  const PlayerPaymentSummary({
    required this.playerId,
    required this.playerName,
    required this.registrationFee,
    required this.amountPaid,
  });

  double get balanceDue =>
      registrationFee - amountPaid;
}