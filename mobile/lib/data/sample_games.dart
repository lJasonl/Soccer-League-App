import '../models/game.dart';

final List<Game> sampleGames = [
  const Game(
    id: '1',
    homeTeam: 'Tigers',
    awayTeam: 'Sharks',
    gameDate: '2026-09-05',
    gameTime: '9:00 AM',
    field: 'Field 1',

    centerRefereeId: '',
    centerRefereeName: '',

    ar1RefereeId: '',
    ar1RefereeName: '',

    ar2RefereeId: '',
    ar2RefereeName: '',

    homeScore: 0,
    awayScore: 0,
  ),

  const Game(
    id: '2',
    homeTeam: 'Eagles',
    awayTeam: 'Dragons',
    gameDate: '2026-09-05',
    gameTime: '10:30 AM',
    field: 'Field 2',

    centerRefereeId: '',
    centerRefereeName: '',

    ar1RefereeId: '',
    ar1RefereeName: '',

    ar2RefereeId: '',
    ar2RefereeName: '',

    homeScore: 0,
    awayScore: 0,
  ),
];