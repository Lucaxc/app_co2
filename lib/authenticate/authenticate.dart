import 'package:PtCO2/ScanningScreen.dart';
import 'package:PtCO2/authenticate/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Autenticate extends StatefulWidget {
  @override
  _AutenticateState createState() => _AutenticateState();
}

class _AutenticateState extends State<Autenticate> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(child: SignIn());
  }
}
