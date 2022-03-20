import 'package:flutter/material.dart';
import 'package:app_co2/WelcomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Co2 First demo',
      home: WelcomeScreen(),
    );
  }
}
