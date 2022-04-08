import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CopyRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SafeArea(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(''),
                  Row(
                    children: [
                      Text("Copyright",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 12,
                                  fontWeight: FontWeight.w300))),
                      Icon(
                        Icons.copyright,
                        size: MediaQuery.of(context).size.width / 25,
                        color: Color(0xFF424242),
                      ),
                      Text(" information",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 12,
                                  fontWeight: FontWeight.w300))),
                    ],
                  ),
                  Text(''),
                  SizedBox(
                    //height: (MediaQuery.of(context).size.width) * 4 / 5,
                    width: (MediaQuery.of(context).size.width) * 4 / 5,
                    child: Text('Insert here copyright information',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: MediaQuery.of(context).size.width / 20,
                              fontWeight: FontWeight.w300),
                        )),
                  )
                ])
          ]),
        )));
  }
}
