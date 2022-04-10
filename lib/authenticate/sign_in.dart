import 'package:PtCO2/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PtCO2/ScanningScreen.dart';
import 'package:PtCO2/wrapper.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

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
                SizedBox(height: 40),
                SizedBox(height: 40),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    color: Color(0xFFFBC02D),
                    minWidth: (MediaQuery.of(context).size.width) * 6 / 7,
                    disabledColor: Color.fromARGB(255, 194, 167, 101),
                    onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if (result == null) {
                        print('Error in signing in');
                      } else {
                        print('Signed in');
                        print(result.uid);
                      }
                      Wrapper(user: result);
                    },
                    child: Text(
                      '  Sign in  ',
                      style: GoogleFonts.catamaran(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 1, 38, 68),
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                SizedBox(height: 20),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    color: Color.fromARGB(2255, 1, 38, 68),
                    minWidth: (MediaQuery.of(context).size.width) * 6 / 7,
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
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ],
            )));
    ;
  }
}
