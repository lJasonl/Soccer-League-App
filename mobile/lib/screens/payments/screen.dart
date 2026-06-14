import 'package:flutter/material.dart';

import '../../services/payment_data_service.dart';
import 'add_payment_screen.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() =>
      _PaymentsScreenState();
}

class _PaymentsScreenState
    extends State<PaymentsScreen> {
  Future<void> _deletePayment(
    String paymentId,
  ) async {
    await PaymentDataService.deletePayment(
      paymentId,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final payments =
        PaymentDataService.payments;

    final summaries =
        PaymentDataService
            .getPlayerSummaries();

    final totalOutstanding =
        summaries.fold<double>(
      0,
      (sum, player) =>
          sum + player.balanceDue,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddPaymentScreen(),
            ),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const Icon(
                Icons.attach_money,
              ),
              title: const Text(
                'Total Collected',
              ),
              subtitle: Text(
                '\$${PaymentDataService.totalCollected.toStringAsFixed(2)}',
              ),
            ),
          ),
          Card(
            margin:
                const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: ListTile(
              leading: const Icon(
                Icons.account_balance_wallet,
              ),
              title: const Text(
                'Outstanding Balance',
              ),
              subtitle: Text(
                '\$${totalOutstanding.toStringAsFixed(2)}',
              ),
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.all(12),
            child: Text(
              'Player Balances',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
          ...summaries.map(
            (summary) => Card(
              margin:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              child: ListTile(
                title: Text(
                  summary.playerName,
                ),
                subtitle: Text(
                  'Paid: \$${summary.amountPaid.toStringAsFixed(2)} / \$${summary.registrationFee.toStringAsFixed(2)}',
                ),
                trailing: Text(
                  '\$${summary.balanceDue.toStringAsFixed(2)}',
                ),
              ),
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.all(12),
            child: Text(
              'Payment History',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
          ...payments.map(
            (payment) => Card(
              margin:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              child: ListTile(
                title: Text(
                  payment.playerName,
                ),
                subtitle: Text(
                  '${payment.paymentMethod} • ${payment.paymentDate}',
                ),
                trailing: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Text(
                      '\$${payment.amount.toStringAsFixed(2)}',
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        _deletePayment(
                          payment.id,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}