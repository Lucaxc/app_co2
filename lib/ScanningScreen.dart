/*
This is the second screen of the application, where information on connected device
utilization are provided. Also copyright information tab is included. By pressing the
search for BLE devices button the application moves to Devices Screen
*/

import 'package:PtCO2/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PtCO2/easterEgg.dart';
import 'package:PtCO2/DevicesScreen.dart';
import 'package:PtCO2/CopyRight.dart';
import 'package:PtCO2/services/authService.dart';
import 'package:PtCO2/wrapper.dart';

class ScanningScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Spacer(flex: 1),
            TextButton(
                child: Text("Hi!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.catamaran(
                      //textStyle: TextStyle(color: Colors.lightBlue),
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                      fontSize: 100,
                      fontWeight: FontWeight.w700,
                    )),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EasterEgg()))),
            Spacer(),
            Text(
                "Please use this device\n always in a controlled\n enviroment. Press the\n button below to\n connect to the device",
                textAlign: TextAlign.center,
                style: GoogleFonts.catamaran(
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 6, 80, 141),
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                )),
            Spacer(),
            FittedBox(
                child: TextButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CopyRight())),
                    child: Row(
                      children: [
                        Text("Copyright",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.catamaran(
                                textStyle: TextStyle(
                                    color: Color(0xFF424242),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300))),
                        SizedBox(width: 6),
                        Icon(
                          Icons.copyright,
                          size: 15,
                          color: Color(0xFF424242),
                        ),
                      ],
                    ))),
            Spacer(flex: 2),
            PrimaryButton(
              text: 'Search for BLE devices',
              press: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DevicesScreen())),
              color: Color(0xFFFBC02D),
              minWidth: (MediaQuery.of(context).size.width) * 5 / 7,
            ),
            PrimaryButton(
              text: 'Sign out',
              press: () async {
                await _auth.signOut();
              },
              color: Color.fromARGB(2255, 1, 38, 68),
              minWidth: (MediaQuery.of(context).size.width) * 5 / 7,
            ),
            Spacer(),
          ],
        )
      ],
    )));
  }
}
