import 'package:PtCO2/Login2/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:PtCO2/api/notification_api.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  Future resetPW() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());

    //Utils.showSnackBar('Email sent');
    NotificationApi.showNotification(
      body: 'You will soon receive an email to restore the password',
      id: 1,
      title: 'Email sent',
      payload: 'payload',
    );
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Icon(
                  Icons.password,
                  size: MediaQuery.of(context).size.width / 5,
                  color: Color.fromARGB(255, 1, 38, 68),
                ),
                SizedBox(height: 20),
                Text(
                    "Insert your email address\nto reset the password.\nWe will send you and email\nwith the instructions to set\na new password",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.catamaran(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 6, 80, 141),
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    )),
                SizedBox(height: 40),
                Material(
                    child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.grey,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                )),
                SizedBox(height: 40),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    color: Color(0xFFFBC02D),
                    minWidth: (MediaQuery.of(context).size.width) * 6 / 7,
                    disabledColor: Color.fromARGB(255, 194, 167, 101),
                    onPressed: resetPW,
                    child: Text(
                      '  Reset password  ',
                      style: GoogleFonts.catamaran(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 1, 38, 68),
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ],
            )));
  }
}
