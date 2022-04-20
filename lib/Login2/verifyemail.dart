import 'dart:async';

import 'package:PtCO2/Login2/ScanningScreenLogged.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:PtCO2/Login2/Wrapper2.dart';
import 'package:PtCO2/Login2/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 2),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print('Error in verifying the mail');
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? ScanningScreenLogged()
      : Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 60),
                      Icon(
                        Icons.verified_user_outlined,
                        size: MediaQuery.of(context).size.width / 5,
                        color: Color.fromARGB(255, 1, 38, 68),
                      ),
                      SizedBox(height: 20),
                      Text("VERIFY YOUR EMAIL",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.catamaran(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 6, 80, 141),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(height: 40),
                      Text("A verification email has \nbeen sent to your email",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.catamaran(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 6, 80, 141),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(height: 40),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          color: Color(0xFFFBC02D),
                          minWidth: (MediaQuery.of(context).size.width) * 6 / 7,
                          disabledColor: Color.fromARGB(255, 194, 167, 101),
                          onPressed: sendVerificationEmail,
                          child: Text(
                            '  Resnd email  ',
                            style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 1, 38, 68),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    ],
                  )
                ],
              )));
}
