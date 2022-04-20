import 'package:PtCO2/Login2/autentication.dart';
import 'package:PtCO2/Login2/verifyemail.dart';
import 'package:PtCO2/ScanningScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ScanningScreenLogged.dart';

class Wrapper2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return VerifyEmail(); //ScanningScreenLogged();
            } else {
              return Autentication();
            }
          }));
}
