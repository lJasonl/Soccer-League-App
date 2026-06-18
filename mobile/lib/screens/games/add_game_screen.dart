import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../models/referee.dart';
import '../../models/team.dart';

import '../../services/game_data_service.dart';
import '../../services/referee_data_service.dart';
import '../../services/team_data_service.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() =>
      _AddGameScreenState();
}

class _AddGameScreenState
    extends State<AddGameScreen> {
  final _formKey =
      GlobalKey<FormState>();

  String? _homeTeam;
  String? _awayTeam;

  Referee? _centerReferee;
  Referee? _ar1Referee;
  Referee? _ar2Referee;

  final _fieldController =
      TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _fieldController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date =
        await showDatePicker(
      context: context,
      initialDate:
          DateTime.now(),
      firstDate:
          DateTime(2024),
      lastDate:
          DateTime(2035),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _pickTime() async {
    final time =
        await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  Future<void> _saveGame() async {

  if (_homeTeam == _awayTeam) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Home Team and Away Team must be different.',
        ),
      ),
    );
    return;
}
  // existing code below
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content:
              Text('Select a date'),
        ),
      );
      return;
    }

    if (_selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content:
              Text('Select a time'),
        ),
      );
      return;
    }

    if (_homeTeam == _awayTeam) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Home and Away teams cannot be the same.',
          ),
        ),
      );
      return;
    }

    final game = Game(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),

      homeTeam: _homeTeam!,
      awayTeam: _awayTeam!,

      gameDate:
          '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}',

      gameTime:
          _selectedTime!
              .format(context),

      field:
          _fieldController.text
              .trim(),

      centerRefereeId:
          _centerReferee?.id ??
              '',

      centerRefereeName:
          _centerReferee
                  ?.fullName ??
              '',

      ar1RefereeId:
          _ar1Referee?.id ??
              '',

      ar1RefereeName:
          _ar1Referee
                  ?.fullName ??
              '',

      ar2RefereeId:
          _ar2Referee?.id ??
              '',

      ar2RefereeName:
          _ar2Referee
                  ?.fullName ??
              '',

      homeScore: 0,
      awayScore: 0,
    );

    await GameDataService
        .addGame(game);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final List<Team> teams =
        TeamDataService.teams;

    final List<Referee>
        referees =
        RefereeDataService
            .referees
            .where(
              (r) =>
                  r.isActive,
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Game',
        ),
      ),
      body:
          SingleChildScrollView(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<
                  String>(
                value: _homeTeam,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Home Team',
                  border:
                      OutlineInputBorder(),
                ),
                items: teams
                    .map(
                      (team) =>
                          DropdownMenuItem(
                        value:
                            team.name,
                        child: Text(
                          team.name,
                        ),
                      ),
                    )
                    .toList(),
                onChanged:
                    (value) {
                  setState(() {
                    _homeTeam =
                        value;
                  });
                },
                validator:
                    (value) {
                  if (value ==
                      null) {
                    return 'Select a home team';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                  String>(
                value: _awayTeam,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Away Team',
                  border:
                      OutlineInputBorder(),
                ),
                items: teams
                    .map(
                      (team) =>
                          DropdownMenuItem(
                        value:
                            team.name,
                        child: Text(
                          team.name,
                        ),
                      ),
                    )
                    .toList(),
                onChanged:
                    (value) {
                  setState(() {
                    _awayTeam =
                        value;
                  });
                },
                validator:
                    (value) {
                  if (value ==
                      null) {
                    return 'Select an away team';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                  Referee>(
                value:
                    _centerReferee,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Center Referee',
                  border:
                      OutlineInputBorder(),
                ),
                items: referees
                    .map(
                      (referee) =>
                          DropdownMenuItem<
                              Referee>(
                        value:
                            referee,
                        child: Text(
                          referee
                              .fullName,
                        ),
                      ),
                    )
                    .toList(),
                onChanged:
                    (value) {
                  setState(() {
                    _centerReferee =
                        value;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                  Referee>(
                value: _ar1Referee,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Assistant Referee 1',
                  border:
                      OutlineInputBorder(),
                ),
                items: referees
                    .map(
                      (referee) =>
                          DropdownMenuItem<
                              Referee>(
                        value:
                            referee,
                        child: Text(
                          referee
                              .fullName,
                        ),
                      ),
                    )
                    .toList(),
                onChanged:
                    (value) {
                  setState(() {
                    _ar1Referee =
                        value;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                  Referee>(
                value: _ar2Referee,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Assistant Referee 2',
                  border:
                      OutlineInputBorder(),
                ),
                items: referees
                    .map(
                      (referee) =>
                          DropdownMenuItem<
                              Referee>(
                        value:
                            referee,
                        child: Text(
                          referee
                              .fullName,
                        ),
                      ),
                    )
                    .toList(),
                onChanged:
                    (value) {
                  setState(() {
                    _ar2Referee =
                        value;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              ListTile(
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                    8,
                  ),
                  side:
                      const BorderSide(),
                ),
                title: Text(
                  _selectedDate ==
                          null
                      ? 'Select Date'
                      : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}',
                ),
                trailing:
                    const Icon(
                  Icons
                      .calendar_month,
                ),
                onTap:
                    _pickDate,
              ),

              const SizedBox(
                height: 16,
              ),

              ListTile(
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                    8,
                  ),
                  side:
                      const BorderSide(),
                ),
                title: Text(
                  _selectedTime ==
                          null
                      ? 'Select Time'
                      : _selectedTime!
                          .format(
                          context,
                        ),
                ),
                trailing:
                    const Icon(
                  Icons
                      .access_time,
                ),
                onTap:
                    _pickTime,
              ),

              const SizedBox(
                height: 16,
              ),

              TextFormField(
                controller:
                    _fieldController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Field',
                  border:
                      OutlineInputBorder(),
                ),
                validator:
                    (value) {
                  if (value ==
                          null ||
                      value
                          .trim()
                          .isEmpty) {
                    return 'Enter a field';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 24,
              ),

              SizedBox(
                width:
                    double.infinity,
                child:
                    ElevatedButton(
                  onPressed:
                      _saveGame,
                  child:
                      const Text(
                    'Save Game',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}