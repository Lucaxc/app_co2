//Obsolete

import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView.builder(
        //itemCount: BLEDevices.length
        itemBuilder: ((context, index) => Text("test")),
      ))
    ]);
  }
}
