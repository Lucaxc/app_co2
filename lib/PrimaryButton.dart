import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.press,
    this.color,
    this.padding = const EdgeInsets.all(5),
    this.minWidth,
  }) : super(key: key);

  final String text;
  final VoidCallback press;
  final color;
  final EdgeInsets padding;
  final minWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        padding: padding,
        color: color,
        minWidth: minWidth,
        onPressed: press,
        child: Text(
          text,
          style: GoogleFonts.catamaran(
            textStyle: TextStyle(
                color: Color(0xFF1A237E),
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
        ));
  }
}
