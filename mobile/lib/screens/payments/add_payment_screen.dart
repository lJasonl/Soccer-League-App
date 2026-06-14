import 'package:flutter/material.dart';

import '../../models/payment.dart';
import '../../models/player.dart';
import '../../services/payment_data_service.dart';
import '../../services/player_data_service.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({
    super.key,
  });

  @override
  State<AddPaymentScreen> createState() =>
      _AddPaymentScreenState();
}

class _AddPaymentScreenState
    extends State<AddPaymentScreen> {
  final _amountController =
      TextEditingController();

  Player? _selectedPlayer;

  String _paymentMethod = 'Cash';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _savePayment() async {
    if (_selectedPlayer == null ||
        _amountController.text.trim().isEmpty) {
      return;
    }

    final amount =
        double.tryParse(
          _amountController.text
              .replaceAll('\$', '')
              .replaceAll(',', '')
              .trim(),
        ) ??
        0;

    final payment = Payment(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      playerId: _selectedPlayer!.id,
      playerName:
          _selectedPlayer!.fullName,
      amount: amount,
      paymentDate:
          DateTime.now()
              .toString()
              .split(' ')
              .first,
      paymentMethod: _paymentMethod,
    );

    await PaymentDataService.addPayment(
      payment,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final players =
        PlayerDataService.players;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Payment',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DropdownButtonFormField<Player>(
              value: _selectedPlayer,
              decoration:
                  const InputDecoration(
                labelText: 'Player',
              ),
              items: players.map((player) {
                return DropdownMenuItem(
                  value: player,
                  child: Text(
                    player.fullName,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPlayer = value;
                });
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText: 'Amount',
                hintText:
                    'Examples: 20, 20.00, \$20, \$1,250.50',
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _paymentMethod,
              items: const [
                DropdownMenuItem(
                  value: 'Cash',
                  child: Text('Cash'),
                ),
                DropdownMenuItem(
                  value: 'Check',
                  child: Text('Check'),
                ),
                DropdownMenuItem(
                  value: 'Card',
                  child: Text('Card'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
              decoration:
                  const InputDecoration(
                labelText:
                    'Payment Method',
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed:
                  _savePayment,
              child: const Text(
                'Save Payment',
              ),
            ),
          ],
        ),
      ),
    );
  }
}