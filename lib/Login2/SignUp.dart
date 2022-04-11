import 'package:PtCO2/Login2/autentication.dart';
import 'package:PtCO2/ScanningScreen.dart';
import 'package:PtCO2/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:PtCO2/Login2/utils.dart';

class SignUp extends StatefulWidget {
  //final Function() onClickedSignIn;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future signUp() async {
    // Check if email and password are valid
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    // Charging animation
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
        child: /*Scaffold(
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ScanningScreen();
                } else {
                  return*/
            Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
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
                          Text("Welcome!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.catamaran(
                                textStyle: TextStyle(
                                    color: Color.fromARGB(255, 6, 80, 141),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400),
                              )),
                          Text("Sign Up to PtCO2",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.catamaran(
                                textStyle: TextStyle(
                                    color: Color.fromARGB(255, 6, 80, 141),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )),
                          SizedBox(height: 40),
                          Material(
                              child: TextFormField(
                            controller: emailController,
                            cursorColor: Colors.grey,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(labelText: 'Email'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                          )),
                          SizedBox(height: 40),
                          Material(
                              child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            cursorColor: Colors.grey,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(labelText: 'Password'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                value != null && value.length < 6
                                    ? 'Enter at least 6 characters'
                                    : null,
                          )),
                          SizedBox(height: 20),
                          RichText(
                              text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: GoogleFonts.catamaran(
                                    textStyle: TextStyle(
                                        color: Color.fromARGB(255, 1, 38, 68),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                25,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  Autentication())),
                                    //TODO: leggere la pressione del tasto indietro e tornare alla home invece che alla schermata prima
                                    text: 'Sign In',
                                    style: GoogleFonts.catamaran(
                                        textStyle: TextStyle(
                                            color: Color(0xFFFBC02D),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                            fontWeight: FontWeight.w400)))
                              ])),
                          SizedBox(height: 40),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              color: Color(0xFFFBC02D),
                              minWidth:
                                  (MediaQuery.of(context).size.width) * 6 / 7,
                              disabledColor: Color.fromARGB(255, 194, 167, 101),
                              onPressed: signUp,
                              child: Text(
                                '  Register  ',
                                style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(255, 1, 38, 68),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                          SizedBox(height: 20),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              color: Color.fromARGB(2255, 1, 38, 68),
                              minWidth:
                                  (MediaQuery.of(context).size.width) * 6 / 7,
                              disabledColor: Color.fromARGB(255, 194, 167, 101),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScanningScreen())),
                              child: Text(
                                ' Continue without login  ',
                                style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                        ],
                      ),
                    ))));
  }
}
