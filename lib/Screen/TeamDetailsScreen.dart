import 'package:flutter/material.dart';
import 'package:four_lab_mba_api/Screen/PlayersScreen.dart';

import '../Model/Team.dart';

class TeamDetailsScreen extends StatelessWidget {
  final Team team;

  TeamDetailsScreen(this.team);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.full_name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Text('Город: ${team.city}', style: TextStyle(fontSize:20),),
            Text('Дивизион: ${team.division}',style: TextStyle(fontSize:20),),
            // Другие детали о команде
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlayersScreen(team),
                  ),
                );
              },
              child: Text('Показать игроков',style: TextStyle(fontSize:18, color: Colors.black), ),
            ),
          ],
        ),
      ),
    );
  }
}
