import 'package:flutter/material.dart';

import '../../services/settings_data_service.dart';

class RegistrationFeeScreen
    extends StatefulWidget {
  const RegistrationFeeScreen({
    super.key,
  });

  @override
  State<RegistrationFeeScreen>
      createState() =>
          _RegistrationFeeScreenState();
}

class _RegistrationFeeScreenState
    extends State<
        RegistrationFeeScreen> {
  late final TextEditingController
      _feeController;

  @override
  void initState() {
    super.initState();

    _feeController =
        TextEditingController(
      text: SettingsDataService
          .settings
          .registrationFee
          .toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _feeController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final fee =
        double.tryParse(
              _feeController.text
                  .replaceAll('\$', '')
                  .replaceAll(',', '')
                  .trim(),
            ) ??
            0;

    await SettingsDataService
        .updateRegistrationFee(
      fee,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Registration fee saved.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration Fee',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'League Registration Fee',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller:
                  _feeController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText:
                    'Registration Fee',
                hintText:
                    'Examples: 50, 50.00, \$50',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            ElevatedButton(
              onPressed: _save,
              child: const Text(
                'Save Fee',
              ),
            ),
          ],
        ),
      ),
    );
  }
}