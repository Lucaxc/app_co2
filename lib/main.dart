import 'package:flutter/material.dart';
import 'package:PtCO2/WelcomeScreen.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  /*
  \brief: This function initializes a workmanager to run the application
  in background
  */
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerOneOffTask("1", "simpleTask");
  runApp(MyApp());
}

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
      debugShowCheckedModeBanner: false,
      title: 'Co2 First demo',
      home: WelcomeScreen(),
    );
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    return Future.value(true);
  });
}
