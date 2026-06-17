import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../models/referee.dart';

import '../../services/game_data_service.dart';
import '../../services/referee_data_service.dart';

class EditGameScreen extends StatefulWidget {
  final Game game;

  const EditGameScreen({
    super.key,
    required this.game,
  });

  @override
  State<EditGameScreen> createState() =>
      _EditGameScreenState();
}

class _EditGameScreenState
    extends State<EditGameScreen> {
  late final TextEditingController
      _homeTeamController;

  late final TextEditingController
      _awayTeamController;

  late final TextEditingController
      _dateController;

  late final TextEditingController
      _timeController;

  late final TextEditingController
      _fieldController;

  Referee? _centerReferee;
  Referee? _ar1Referee;
  Referee? _ar2Referee;

  @override
  void initState() {
    super.initState();

    _homeTeamController =
        TextEditingController(
      text: widget.game.homeTeam,
    );

    _awayTeamController =
        TextEditingController(
      text: widget.game.awayTeam,
    );

    _dateController =
        TextEditingController(
      text: widget.game.gameDate,
    );

    _timeController =
        TextEditingController(
      text: widget.game.gameTime,
    );

    _fieldController =
        TextEditingController(
      text: widget.game.field,
    );

    try {
      _centerReferee =
          RefereeDataService.referees
              .firstWhere(
        (r) =>
            r.id ==
            widget.game
                .centerRefereeId,
      );
    } catch (_) {}

    try {
      _ar1Referee =
          RefereeDataService.referees
              .firstWhere(
        (r) =>
            r.id ==
            widget.game
                .ar1RefereeId,
      );
    } catch (_) {}

    try {
      _ar2Referee =
          RefereeDataService.referees
              .firstWhere(
        (r) =>
            r.id ==
            widget.game
                .ar2RefereeId,
      );
    } catch (_) {}
  }

  @override
  void dispose() {
    _homeTeamController.dispose();
    _awayTeamController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _fieldController.dispose();

    super.dispose();
  }

  void _saveChanges() {
    final updatedGame = Game(
      id: widget.game.id,

      homeTeam:
          _homeTeamController.text,

      awayTeam:
          _awayTeamController.text,

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

      homeScore:
          widget.game.homeScore,

      awayScore:
          widget.game.awayScore,
    );

    GameDataService.updateGame(
      updatedGame,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final referees =
        RefereeDataService
            .referees
            .where(
              (r) => r.isActive,
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Game',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: ListView(
          children: [
            TextField(
              controller:
                  _homeTeamController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Home Team',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  _awayTeamController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Away Team',
              ),
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
              height: 24,
            ),

            ElevatedButton(
              onPressed:
                  _saveChanges,
              child: const Text(
                'Save Changes',
              ),
            ),
          ],
        ),
      ),
    );
  }
}