import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../models/team.dart';
import '../../models/referee.dart';

import '../../services/game_data_service.dart';
import '../../services/team_data_service.dart';
import '../../services/referee_data_service.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() =>
      _AddGameScreenState();
}

class _AddGameScreenState
    extends State<AddGameScreen> {
  String? _homeTeam;

  String? _awayTeam;

  Referee? _centerReferee;
  Referee? _ar1Referee;
  Referee? _ar2Referee;

  final _dateController =
      TextEditingController();

  final _timeController =
      TextEditingController();

  final _fieldController =
      TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  void _saveGame() {
    if (_homeTeam == null ||
        _awayTeam == null) {
      return;
    }

    if (_homeTeam ==
        _awayTeam) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Home and Away teams must be different.',
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
          _dateController.text,

      gameTime:
          _timeController.text,

      field:
          _fieldController.text,

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

    GameDataService.addGame(
      game,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final List<Team>
        teams =
        TeamDataService.teams;

    final referees =
        RefereeDataService
            .referees
            .where(
              (ref) =>
                  ref.isActive,
            )
            .toList();

    if (_homeTeam == null &&
        teams.isNotEmpty) {
      _homeTeam =
          teams.first.name;
    }

    if (_awayTeam == null &&
        teams.length > 1) {
      _awayTeam =
          teams[1].name;
    } else if (_awayTeam ==
            null &&
        teams.isNotEmpty) {
      _awayTeam =
          teams.first.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Game',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: ListView(
          children: [
            DropdownButtonFormField<
                String>(
              value: _homeTeam,
              decoration:
                  const InputDecoration(
                labelText:
                    'Home Team',
              ),
              items: teams
                  .map(
                    (team) =>
                        DropdownMenuItem<
                            String>(
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
              ),
              items: teams
                  .map(
                    (team) =>
                        DropdownMenuItem<
                            String>(
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
              value:
                  _ar1Referee,
              decoration:
                  const InputDecoration(
                labelText:
                    'Assistant Referee 1',
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
              value:
                  _ar2Referee,
              decoration:
                  const InputDecoration(
                labelText:
                    'Assistant Referee 2',
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

            TextField(
              controller:
                  _dateController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Game Date',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  _timeController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Game Time',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  _fieldController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Field',
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            ElevatedButton(
              onPressed:
                  _saveGame,
              child: const Text(
                'Save Game',
              ),
            ),
          ],
        ),
      ),
    );
  }
}