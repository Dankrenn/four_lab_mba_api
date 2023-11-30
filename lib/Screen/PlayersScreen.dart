import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:four_lab_mba_api/Model/Players.dart';
import 'package:http/http.dart' as http;
import '../Model/Team.dart';

class PlayersScreen extends StatelessWidget {
  final Team teamc;
  PlayersScreen(this.teamc);

  List<Player> players = [];

  Future<List<Player>> getPlayers() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/players'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (var playerData in jsonData['data']) {
        var player = Player(
          first_name: playerData['first_name'],
          last_name: playerData['last_name'],
        );

        var teamData = playerData['team'];
        if (teamData != null) {
          player.team = Team(
            abbreviation: teamData['abbreviation'],
            city: teamData['city'],
            division: teamData['division'],
            full_name: teamData['full_name'],
          );
        }

        players.add(player);
      }
      return players;
    } else {
      throw Exception('Failed to load players');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
            appBar: AppBar(
              title: Text('NBA Players'),
            ),
          body: FutureBuilder(
            future: getPlayers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // ...

                return ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    if (players[index].team.abbreviation == teamc.abbreviation) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start, // Это выравнивание текста в левой части
                            children: [
                              // Вместо Column используем Expanded + Column для правильного выравнивания
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(players[index].first_name, style: TextStyle(fontSize: 20)),
                                      Padding(padding: const EdgeInsets.all(5)),
                                      Text(players[index].last_name, style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink(); // Пропустить элемент списка, если команда не соответствует выбранной
                    }
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

        ),
    );
  }
}
