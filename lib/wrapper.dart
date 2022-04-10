import 'package:PtCO2/ScanningScreen.dart';
import 'package:PtCO2/authenticate/authenticate.dart';
import 'package:PtCO2/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final App_User? user;

  const Wrapper({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<App_User?>(context);
    print(user);

    if (user == null) {
      return Autenticate();
    } else {
      return ScanningScreen();
    }
  }
}
