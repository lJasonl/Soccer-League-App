import '../models/payment.dart';
import '../models/player_payment_summary.dart';
import 'player_data_service.dart';
import 'settings_data_service.dart';
import 'storage_service.dart';

class PaymentDataService {
  static List<Payment> payments = [];

  static Future<void> loadPayments() async {
    final box = StorageService.getPaymentsBox();

    if (box.isEmpty) {
      return;
    }

    payments = box.values.map((item) {
      final data = Map<String, dynamic>.from(item);

      return Payment(
        id: data['id'],
        playerId: data['playerId'],
        playerName: data['playerName'],
        amount:
            (data['amount'] as num)
                .toDouble(),
        paymentDate:
            data['paymentDate'],
        paymentMethod:
            data['paymentMethod'],
      );
    }).toList();
  }

  static Future<void> savePayments() async {
    final box = StorageService.getPaymentsBox();

    await box.clear();

    for (final payment in payments) {
      await box.add({
        'id': payment.id,
        'playerId': payment.playerId,
        'playerName':
            payment.playerName,
        'amount': payment.amount,
        'paymentDate':
            payment.paymentDate,
        'paymentMethod':
            payment.paymentMethod,
      });
    }
  }

  static Future<void> addPayment(
    Payment payment,
  ) async {
    payments.add(payment);

    await savePayments();
  }

  static Future<void> deletePayment(
    String paymentId,
  ) async {
    payments.removeWhere(
      (payment) =>
          payment.id == paymentId,
    );

    await savePayments();
  }

  static double get totalCollected {
    double total = 0;

    for (final payment in payments) {
      total += payment.amount;
    }

    return total;
  }

  static List<PlayerPaymentSummary>
      getPlayerSummaries() {
    final registrationFee =
        SettingsDataService
            .settings
            .registrationFee;

    return PlayerDataService.players.map(
      (player) {
        double amountPaid = 0;

        for (final payment
            in payments) {
          if (payment.playerId ==
              player.id) {
            amountPaid +=
                payment.amount;
          }
        }

        return PlayerPaymentSummary(
          playerId: player.id,
          playerName:
              player.fullName,
          registrationFee:
              registrationFee,
          amountPaid:
              amountPaid,
        );
      },
    ).toList();
  }
}