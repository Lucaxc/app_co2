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

class ScanningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Spacer(flex: 2),
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
            Spacer(flex: 4),
            PrimaryButton(
              text: 'Search for BLE devices',
              press: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DevicesScreen())),
              color: Color(0xFFFBC02D),
              minWidth: (MediaQuery.of(context).size.width) * 5 / 7,
            ),
            Spacer(),
          ],
        )
      ],
    )));
  }
}
