import 'package:flutter/material.dart';
import 'package:four_lab_mba_api/Screen/TeamsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TeamsScreen(), // Используйте TeamsScreen в качестве главного экрана
    );
  }
}


