import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class HelpWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SafeArea(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              Text(''),
              Row(
                children: [
                  Text("Contacts",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: MediaQuery.of(context).size.width / 12,
                              fontWeight: FontWeight.w300))),
                  Text(" information",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: MediaQuery.of(context).size.width / 12,
                              fontWeight: FontWeight.w300))),
                ],
              ),
              Text(''),
              SizedBox(
                //height: (MediaQuery.of(context).size.width) * 4 / 5,
                width: (MediaQuery.of(context).size.width) * 4 / 5,
                child: Text('For any issue contact:',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.catamaran(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 1, 38, 68),
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontWeight: FontWeight.w300),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Text('lucacolombo29@gmail.com\n',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color(0xFFFBC02D),
                              fontSize: MediaQuery.of(context).size.width / 22,
                              fontWeight: FontWeight.w300),
                        )),
                  ])
                ],
              ),
              SizedBox(
                //height: (MediaQuery.of(context).size.width) * 4 / 5,
                width: (MediaQuery.of(context).size.width) * 4 / 5,
                child: Text('Donations for the project:',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.catamaran(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 1, 38, 68),
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontWeight: FontWeight.w300),
                    )),
              ),
              RichText(
                  text: TextSpan(
                      text: '',
                      style: GoogleFonts.catamaran(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 1, 38, 68),
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.w400),
                      ),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launch(
                              'https://paypal.me/LucaColomboxc?country.x=IT&locale.x=it_IT'),
                        text:
                            'https://paypal.me/LucaColomboxc\n?country.x=IT&locale.x=it_IT\n',
                        style: GoogleFonts.catamaran(
                            textStyle: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFFFBC02D),
                                fontSize:
                                    MediaQuery.of(context).size.width / 22,
                                fontWeight: FontWeight.w400)))
                  ])),
              SizedBox(
                width: (MediaQuery.of(context).size.width) * 4 / 5,
                child: Text('User guide:',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.catamaran(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 1, 38, 68),
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontWeight: FontWeight.w300),
                    )),
              ),
              RichText(
                  text: TextSpan(
                      text: '',
                      style: GoogleFonts.catamaran(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 1, 38, 68),
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.w400),
                      ),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launch(
                              'https://paypal.me/LucaColomboxc?country.x=IT&locale.x=it_IT'),
                        text:
                            'https://paypal.me/LucaColomboxc\n?country.x=IT&locale.x=it_IT\n',
                        style: GoogleFonts.catamaran(
                            textStyle: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFFFBC02D),
                                fontSize:
                                    MediaQuery.of(context).size.width / 22,
                                fontWeight: FontWeight.w400)))
                  ])),
            ])
          ]),
        )));
  }
}
