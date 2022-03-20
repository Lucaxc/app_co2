import 'package:app_co2/ScanningScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Spacer(),
              Container(
                  height: 100,
                  width: 200,
                  child: Positioned(
                    top: 100,
                    child: Image.asset("assets/co22.jpg"),
                  )),
              Spacer(),
              Text("PtCO2 Monitor",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.catamaran(
                    textStyle: TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  )),
              Text("Provided by LaRes Lab, PoliMi",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.catamaran(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 6, 80, 141),
                        fontSize: 30,
                        fontWeight: FontWeight.w300),
                  )),
              Spacer(flex: 3),
              FittedBox(
                  child: TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScanningScreen())),
                      child: Row(
                        children: [
                          Text("Skip",
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
    );
  }
}
