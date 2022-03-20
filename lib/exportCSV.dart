import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_co2/DataVisualization.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

int CSV_count = 0;

class ExportCSV extends StatelessWidget {
  final List<List<String>> dataForCSV;
  final String date;

  const ExportCSV({Key? key, required this.dataForCSV, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String csv = const ListToCsvConverter().convert(dataForCSV);

    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.description),
                title:
                    Text('Recorded CO2 data ${CSV_count.toString()} - ${date}'),
                trailing: IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () => saveFile(csv),
                ),
              ),
              Text(csv.toString())
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 1, 38, 68),
      title: Text("List of available CSV",
          style: GoogleFonts.catamaran(
            textStyle: TextStyle(color: Colors.white),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}

Future<String> getFilePath() async {
  Directory? appDocumentsDirectory = await getExternalStorageDirectory(); // 1
  String appDocumentsPath = appDocumentsDirectory!.path; // 2
  String filePath = '$appDocumentsPath/CO2_data.csv'; // 3

  return filePath;
}

void saveFile(String csv) async {
  File file = File(await getFilePath()); // 1
  file.writeAsString(csv); // 2
}

void readFile() async {
  File file = File(await getFilePath()); // 1
  String fileContent = await file.readAsString(); // 2

  print('File Content: $fileContent');
}
