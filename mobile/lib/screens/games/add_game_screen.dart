import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../services/game_data_service.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final _formKey = GlobalKey<FormState>();

  final _homeTeamController = TextEditingController();
  final _awayTeamController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _fieldController = TextEditingController();

  @override
  void dispose() {
    _homeTeamController.dispose();
    _awayTeamController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  Future<void> _saveGame() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final game = Game(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      homeTeam: _homeTeamController.text.trim(),
      awayTeam: _awayTeamController.text.trim(),
      gameDate: _dateController.text.trim(),
      gameTime: _timeController.text.trim(),
      field: _fieldController.text.trim(),
      homeScore: 0,
      awayScore: 0,
    );

    await GameDataService.addGame(game);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Game'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _homeTeamController,
                decoration: const InputDecoration(
                  labelText: 'Home Team',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter home team';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _awayTeamController,
                decoration: const InputDecoration(
                  labelText: 'Away Team',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter away team';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Game Date',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter game date';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Game Time',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter game time';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _fieldController,
                decoration: const InputDecoration(
                  labelText: 'Field',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter field';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveGame,
                  child: const Text('Save Game'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}