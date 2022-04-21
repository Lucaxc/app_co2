import 'package:PtCO2/api/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PtCO2/DataVisualization.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:PtCO2/api/upload_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

String date_export = '';

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

  @override
  void initState() {
    //super.initState();
    NotificationApi.init();
    listenNotifications();
  }

/*   Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;

    return File(result.files.first.path!);
  } 

  Future openFile() async {
    final file = await pickFile();
  }*/

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    //Open single file
    final file_open = result.files.first;
    print('Name: ${file_open.name}');
    print('Path: ${file_open.path}');
    openSingleFile(file_open);
    print(
        '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++notification pressed');
  }

  @override
  Widget build(BuildContext context) {
    String csv = const ListToCsvConverter().convert(dataForCSV);
    date_export = date;

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
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  color: Color(0xFFFBC02D),
                  minWidth: (MediaQuery.of(context).size.width) * 6 / 7,
                  disabledColor: Color.fromARGB(255, 194, 167, 101),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result == null) return;

                    //Open single file
                    final file = result.files.first;
                    print('Name: ${file.name}');
                    print('Path: ${file.path}');
                    openSingleFile(file);
                  },
                  child: Text(
                    '  Pick file  ',
                    style: GoogleFonts.catamaran(
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 1, 38, 68),
                          fontSize: MediaQuery.of(context).size.width / 25,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
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

//To open single files (open_files library imported)
void openSingleFile(PlatformFile file) {
  OpenFile.open(file.path!);
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
Future saveFile(String csv) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  String dir = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOADS);
  print("dir $dir");
  String file = "$dir";

  File f = File(file + "/CO2_data_exported.csv");
  f.writeAsString(csv);

  // ignore: todo
  //TODO: have a working notification below (FIXED): This is for local storage
  NotificationApi.showNotification(
    body: 'The file has been saved in the DOWNLOAD folder',
    id: 0,
    title: 'CSV Export completed',
    payload: 'payload2',
  );

  final user = FirebaseAuth.instance.currentUser!;
  if (user.email != null) {
    final destination =
        '${user.email}/files/CO2_data_exported - ${date_export}';
    FirebaseApi.uploadFile(destination, f);
  }

  // ignore: todo
  //TODO: have a working notification below (FIXED): This is for FIREBASE storage
  NotificationApi.showNotification(
    body: 'The file has been saved on Google Firebase',
    id: 1,
    title: 'CSV Export completed',
    payload: 'payload2',
  );
}
