import 'package:PtCO2/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PtCO2/DataVisualization.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportCSV extends StatelessWidget {
  final List<List<String>> dataForCSV;
  final String date;
  final int CSV_count;

  const ExportCSV(
      {Key? key,
      required this.dataForCSV,
      required this.date,
      required this.CSV_count})
      : super(key: key);

  /*@override
  void initState() {
    //super.initState();
    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => () {};*/

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
              Text(csv.toString()),
              //StreamBuilder(builder: (context, snapshot) => updateCSVcount()),
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

updateCSVcount() {
  CSV_count = CSV_count + 1;
}

//To get directory path for the external storage folder
Future<String> getFilePath() async {
  Directory? appDocumentsDirectory = await getExternalStorageDirectory();
  print(appDocumentsDirectory?.path); // 1
  String appDocumentsPath = appDocumentsDirectory!.path; // 2
  String filePath = '$appDocumentsPath/CO2_data.csv'; // 3

  return filePath;
}

//To read files from storage
void readFile() async {
  File file = File(await getFilePath()); // 1
  String fileContent = await file.readAsString(); // 2

  print('File Content: $fileContent');
}

//To save files in local storage
void saveFile(String csv) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  String dir = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOADS);
  print("dir $dir");
  String file = "$dir";

  File f = File(file + "/CO2_data_exported.csv");
  f.writeAsString(csv);
  /*NotificationApi.showNotification(
    title: 'Download Completed',
    body: 'CSV file exported',
  );*/
}
