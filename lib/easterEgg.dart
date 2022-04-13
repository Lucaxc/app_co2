import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EasterEgg extends StatelessWidget {
  const EasterEgg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.emoji_emotions,
                              size: MediaQuery.of(context).size.width / 2,
                              color: Color.fromARGB(255, 1, 38, 68),
                            ),
                          ])
                    ]),
              ),
            )));
  }
}
