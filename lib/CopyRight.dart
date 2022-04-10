import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CopyRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SafeArea(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(''),
                  Row(
                    children: [
                      Text("Copyright",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 12,
                                  fontWeight: FontWeight.w300))),
                      Icon(
                        Icons.copyright,
                        size: MediaQuery.of(context).size.width / 25,
                        color: Color(0xFF424242),
                      ),
                      Text(" information",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 12,
                                  fontWeight: FontWeight.w300))),
                    ],
                  ),
                  Text(''),
                  SizedBox(
                    //height: (MediaQuery.of(context).size.width) * 4 / 5,
                    width: (MediaQuery.of(context).size.width) * 4 / 5,
                    child: Text(
                        'Copyright (c) 2022, Luca Colombo. All rights reserved.\n\n'
                        'Redistribution and use in source and binary forms, with or without modification, '
                        'are permitted provided that the following conditions are met:\n\n'
                        '-- Redistributions of source code must retain the above copyright notice, this list of '
                        'conditions and the following disclaimer.\n\n'
                        '-- Redistribution in binary form must reproduce the above copyright notice, this list '
                        'of conditions and the following disclaimer in the documentation and/or other materials '
                        'provided with the distribution.\n\n'
                        '-- Neither the name of Luca Colombo or of the application can be used to endorse or '
                        'promote products derived from this application without prior written permission\n\n'
                        'THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY '
                        'EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT '
                        'LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR '
                        'A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT '
                        'OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, '
                        'SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT '
                        'LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, '
                        'DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY '
                        'THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT '
                        '(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE '
                        'OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: MediaQuery.of(context).size.width / 30,
                              fontWeight: FontWeight.w300),
                        )),
                  )
                ])
          ]),
        )));
  }
}
