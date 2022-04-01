import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EasterEgg extends StatelessWidget {
  const EasterEgg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SingleChildScrollView(
                child: SafeArea(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: (MediaQuery.of(context).size.width) * 2 / 5,
                          width: (MediaQuery.of(context).size.width) * 2 / 5,
                          child: Positioned(
                            top: 100,
                            child: Image.asset("assets/images/CV2.jpg"),
                          )),
                      SizedBox(
                        //height: (MediaQuery.of(context).size.width) * 4 / 5,
                        width: (MediaQuery.of(context).size.width) * 4 / 5,
                        child: Text(
                            'Hi! If you are here it means that you have used long enough the app to press things randomly and find this easter egg. I\'m Luca and I\'ve developed this app as part of my work of thesis, hope you enjoyed it. HAVE FUN!',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 6, 80, 141),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            )),
                      )
                    ])
              ]),
        ))));
  }
}
