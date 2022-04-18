import 'package:PtCO2/Login2/SignUp.dart';
import 'package:PtCO2/Login2/forgotPassword.dart';
import 'package:PtCO2/Login2/googleLogIn.dart';
import 'package:PtCO2/Login2/utils.dart';
import 'package:PtCO2/ScanningScreen.dart';
import 'package:PtCO2/help.dart';
import 'package:PtCO2/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Autentication extends StatefulWidget {
  @override
  _AutenticationState createState() => _AutenticationState();
}

class _AutenticationState extends State<Autentication> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future signIn() async {
    // Charging animation
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    // Stop the animation
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          print('Back button pressed');
          return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Icon(
                      Icons.account_circle,
                      size: MediaQuery.of(context).size.width / 5,
                      color: Color.fromARGB(255, 1, 38, 68),
                    ),
                    SizedBox(height: 20),
                    Text("Welcome back!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 6, 80, 141),
                              fontSize: 25,
                              fontWeight: FontWeight.w400),
                        )),
                    Text("Sign in to PtCO2",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 6, 80, 141),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        )),
                    SizedBox(height: 40),
                    Material(
                        child: TextField(
                      controller: emailController,
                      cursorColor: Colors.grey,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'Email'),
                    )),
                    SizedBox(height: 40),
                    Material(
                        child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      cursorColor: Colors.grey,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'Password'),
                    )),
                    SizedBox(height: 20),
                    RichText(
                        text: TextSpan(
                            text: 'New to PtCO2? ',
                            style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 1, 38, 68),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.w400),
                            ),
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SignUp())),
                              text: 'Register',
                              style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFFFBC02D),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w400)))
                        ])),
                    SizedBox(height: 30),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        color: Color(0xFFFBC02D),
                        minWidth: (MediaQuery.of(context).size.width) * 6 / 7,
                        disabledColor: Color.fromARGB(255, 194, 167, 101),
                        onPressed: signIn,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '  Sign in  ',
                                style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(255, 1, 38, 68),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ])),
                    SizedBox(height: 20),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        color: Colors.white,
                        minWidth: (MediaQuery.of(context).size.width) * 6 / 7,
                        disabledColor: Color.fromARGB(255, 194, 167, 101),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.google,
                                  color: Color(0xFFFBC02D), size: 20),
                              Text(
                                '   Sign in with Google',
                                style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(2255, 1, 38, 68),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ])),
                    SizedBox(height: 20),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        color: Color.fromARGB(2255, 1, 38, 68),
                        minWidth: (MediaQuery.of(context).size.width) * 6 / 7,
                        disabledColor: Color.fromARGB(255, 194, 167, 101),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanningScreen())),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' Continue without Log In  ',
                                style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ])),
                    SizedBox(height: 30),
                    RichText(
                        text: TextSpan(
                            text: 'Forgot your ',
                            style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 1, 38, 68),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.w400),
                            ),
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword())),
                              text: 'password',
                              style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFFFBC02D),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w400))),
                          TextSpan(
                            text: '?',
                            style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 1, 38, 68),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ])),
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(
                            text: 'Need ',
                            style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 1, 38, 68),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.w400),
                            ),
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => HelpWidget())),
                              text: 'HELP',
                              style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFFFBC02D),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w400))),
                          TextSpan(
                            text: '?',
                            style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 1, 38, 68),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ])),
                  ],
                ))));
  }
}
