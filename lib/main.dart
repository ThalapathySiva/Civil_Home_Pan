import 'package:civil_home_plan/screens/home_screen.dart';
import 'package:civil_home_plan/screens/result_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => HomeScreen(),
        '/ResultScreen': (BuildContext context) => ResultScreen()
      },
    );
  }
}
