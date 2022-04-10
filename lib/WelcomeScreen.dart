/*
This is the first screen of the application where PoliMi logo, name of the application
and application executive logo are displayed. By pressing the skip button the application
moves to Scanning Screen
*/

import 'package:PtCO2/ScanningScreen.dart';
import 'package:PtCO2/autentication.dart';
import 'package:PtCO2/authenticate/authenticate.dart';
import 'package:PtCO2/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:PtCO2/models/user.dart';
import 'package:PtCO2/services/authService.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<App_User?>.value(
        value: AuthService().user,
        initialData: null,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Spacer(),

                  //PoliMi Logo
                  Container(
                      height: (MediaQuery.of(context).size.width) * 2 / 5,
                      width: (MediaQuery.of(context).size.width) * 2 / 5,
                      child: Positioned(
                        top: 100,
                        child: Image.asset(
                            "assets/images/Logo_Politecnico_Milano.png"),
                      )),
                  Spacer(),

                  //App name
                  Text("PtCO2 Monitor",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.catamaran(
                        textStyle:
                            TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                        fontSize: MediaQuery.of(context).size.width / 9,
                        fontWeight: FontWeight.w700,
                      )),
                  Text("Provided by LaRes Lab",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.catamaran(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 6, 80, 141),
                            fontSize: MediaQuery.of(context).size.width / 14,
                            fontWeight: FontWeight.w300),
                      )),
                  Spacer(flex: 2),

                  //App executive logo
                  Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Positioned(
                        top: 100,
                        child: Image.asset("assets/images/Intrologo.jpg"),
                      )),
                  Spacer(flex: 3),

                  //Skip button
                  FittedBox(
                      child: TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wrapper(user: null))),
                          child: Row(
                            children: [
                              Text("Login",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300))),
                              SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward,
                                size: 15,
                                color: Color(0xFF424242),
                              ),
                            ],
                          )))
                ])
              ])),
        ));
  }
}
