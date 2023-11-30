import 'dart:convert';
import 'package:flutter/material.dart';
import '../Model/Team.dart';
import 'package:http/http.dart' as http;

import 'TeamDetailsScreen.dart';

class TeamsScreen extends StatelessWidget {
  TeamsScreen({super.key});
  List<Team> teams = [];

  Future<List<Team>> getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    print(response.body);
    if (response.statusCode >= 200) {
      var jsonData = jsonDecode(response.body);

      for (var eachTeam in jsonData['data']) {
        final team = Team(
          abbreviation: eachTeam['abbreviation'],
          city: eachTeam['city'],
          division: eachTeam['division'],
          full_name: eachTeam['full_name'],
        );
        teams.add(team);
      }

      return teams; // This line is important to return the list of teams
    } else {
      throw Exception('Failed to load teams');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("NBA TEAMS"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: FutureBuilder(
          future: getTeams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    child: Container(
                        decoration: BoxDecoration(color: Colors.black12),
                        child:TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TeamDetailsScreen(teams[index]),
                              ),
                            );
                          },

                          child: ListTile(
                            title: Text(teams[index].abbreviation , style: TextStyle(fontSize: 18,),),
                            subtitle: Text(teams[index].city,  style: TextStyle(fontSize: 16),),
                          ),
                        )
                    ),
                  );
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