import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_co2/DataVisualization.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

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
                  onPressed: () {},
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

/* Future<void> writeCSV (String csv) async {

String dir = (await getApplicationDocumentsDirectory()).path;
  String path = "$dir/CO2_data.csv";


File file = File(fileBits, fileName)

file.writeAsString(csv);
} 
 */