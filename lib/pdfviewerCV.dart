import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class pdfViewerCV extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfPdfViewer.asset(
      'assets/pdf/CV_Eng.pdf',
    ));
  }
}
