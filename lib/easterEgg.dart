import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EasterEgg extends StatelessWidget {
  const EasterEgg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Column(children: [
                Spacer(),
                Icon(
                  Icons.emoji_emotions,
                  size: MediaQuery.of(context).size.width / 2,
                  color: Color.fromARGB(255, 1, 38, 68),
                ),
                Spacer(),
              ])
            ])));
  }
}
