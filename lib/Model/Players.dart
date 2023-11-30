import 'Team.dart';

class Player
{
  final first_name;
  final last_name;
  Team team = Team(abbreviation: 'abbreviation', city: 'city', division: 'division', full_name: 'full_name');

  Player(
      {required this.first_name,
        required this.last_name,}
      );
}