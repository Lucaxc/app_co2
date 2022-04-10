import 'package:PtCO2/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PtCO2/WelcomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:PtCO2/models/user.dart';

void main() async {
  /*
  \brief: This function initializes a workmanager to run the application
  in background
  */
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerOneOffTask("1", "simpleTask");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
