import 'dart:math';
import 'dart:ui';
import 'package:PtCO2/exportCSV.dart';
import 'package:PtCO2/dataChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'package:wakelock/wakelock.dart';

int time = 0;
int CO2Data_000 = 0;
int CO2Data_00 = 0;
int CO2Data_0 = 0;
int CO2Data_1 = 0;
int CO2Data_2 = 0;
double C02_Data_2_double = 0.0;
int CSV_count = 0;

List<List<String>> dataForCSV = [
  ['Time', 'CO2 Value']
];

List<ChartData> dataForPlot = [];
ChartData CO2_for_plot = ChartData(0, 0);

double screen_width = 1.0;
double screen_height = 1.0;

ViewConfiguration createViewConfiguration() {
  final double devicePixelRatio = window.devicePixelRatio;
  return ViewConfiguration(
    devicePixelRatio: devicePixelRatio,
  );
}

//List<int> CO2_array = [];
//final List<int> charCodes = const [97, 98, 99, 100];
late List<LiveData> chartData;
late ChartSeriesController _chartSeriesController;

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final int speed;
}

DateTime now = DateTime.now();
String formattedDate = '';
String formattedDate_export = '';
//List<int> value = [];

class DataVisualization extends StatelessWidget {
  final BluetoothDevice device;
  final BluetoothService service;
  final BluetoothCharacteristic characteristic;

  const DataVisualization(
      {Key? key,
      required this.device,
      required this.service,
      required this.characteristic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screen_width = MediaQuery.of(context).size.width;
    screen_height = MediaQuery.of(context).size.height;
    Wakelock.enable();
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  StreamBuilder<List<int>>(
                      stream: characteristic.value,
                      initialData: characteristic.lastValue,
                      builder: (c, snapshot) {
                        final value = snapshot.data;

                        //Data collection
                        CO2Data_000 = CO2Data_00;
                        CO2Data_00 = CO2Data_0;
                        CO2Data_0 = CO2Data_1;
                        CO2Data_1 = CO2Data_2;
                        CO2Data_2 = returnInteger(value as List<int>);

                        //Chart data setup
                        C02_Data_2_double = CO2Data_2.toDouble();
                        time = time + 1;
                        CO2_for_plot = ChartData(time, C02_Data_2_double);
                        dataForPlot.add(CO2_for_plot);

                        //Time saving and display
                        now = DateTime.now();
                        formattedDate =
                            DateFormat('yyyy-MM-dd – kk:mm:ss').format(now);
                        formattedDate_export =
                            DateFormat('yyyy-MM-dd/kk:mm:ss').format(now);

                        //CSV setup
                        dataForCSV.addAll([
                          [formattedDate_export, CO2Data_2.toString()]
                        ]);

                        /* dataForPlot.addAll([
                          [time, CO2Data_2 as double]
                        ]); */

                        String csv =
                            const ListToCsvConverter().convert(dataForCSV);
                        print('Device pixel ratio');
                        print(devicePixelRatio);
                        //Visual return
                        return Container(
                            //child: SingleChildScrollView(
                            //  scrollDirection: Axis.vertical,
                            child: Column(children: <Widget>[
                          Container(
                            color: Colors.amber,
                            height: screen_height / 80,
                            width: MediaQuery.of(context).size.width,
                          ),
                          //Text(' '),

                          Text('Measured CO2 value',
                              style: GoogleFonts.catamaran(
                                textStyle: TextStyle(
                                    color: Color.fromARGB(255, 1, 38, 68)),
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              )),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(CO2Data_2.toString(),
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 26, 201, 19)),
                                      //fontSize: 70,
                                      fontSize: screen_height / 11,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text(' ppm',
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 26, 201, 19)),
                                      //fontSize: 20,
                                      fontSize: screen_height / 30,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),

                          Text(formattedDate_export.toString(),
                              style: GoogleFonts.catamaran(
                                textStyle: TextStyle(
                                    color: Color.fromARGB(255, 1, 38, 68)),
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              )),

                          Container(
                            color: Colors.amber,
                            height: screen_height / 80,
                            //height: 10,
                            width: MediaQuery.of(context).size.width,
                          ),

                          Text(''),

                          Text('Previous values',
                              style: GoogleFonts.catamaran(
                                textStyle: TextStyle(
                                    color: Color.fromARGB(255, 1, 38, 68)),
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              )),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(CO2Data_1.toString(),
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 1, 38, 68)),
                                      //fontSize: 50,
                                      fontSize: screen_height / 17,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text(' ppm',
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 1, 38, 68)),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(CO2Data_0.toString(),
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color:
                                              //Color.fromARGB(255, 6, 60, 104)),
                                              Color.fromARGB(255, 14, 78, 131)),
                                      fontSize: screen_height / 17,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text(' ppm',
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 14, 78, 131)),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(CO2Data_00.toString(),
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color:
                                              //Color.fromARGB(255, 14, 78, 131)),
                                              Color.fromARGB(
                                                  255, 28, 105, 168)),
                                      fontSize: screen_height / 17,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text(' ppm',
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 28, 105, 168)),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(CO2Data_000.toString(),
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color: //Color.fromARGB(255, 28, 105, 168)
                                              Color.fromARGB(
                                                  255, 67, 152, 221)),
                                      fontSize: screen_height / 17,
                                      fontWeight: FontWeight.w700,
                                    )),
                                Text(' ppm',
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 67, 152, 221)),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),

                          Text(''),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: screen_height / 100,
                                      horizontal: screen_width / 8),
                                  color: Color.fromARGB(255, 9, 56, 211),
                                  minWidth:
                                      MediaQuery.of(context).size.width / 3,
                                  disabledColor:
                                      Color.fromARGB(255, 194, 167, 101),
                                  onPressed: () => exportCSV(context),
                                  /*Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => ExportCSV(
                                                dataForCSV: dataForCSV,
                                                date: formattedDate_export,
                                              ))),*/
                                  child: Text(
                                    '  EXPORT CSV  ',
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              36,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 15),
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: screen_height / 100,
                                      horizontal: screen_width / 40),
                                  color: Color(0xFFFBC02D),
                                  minWidth:
                                      MediaQuery.of(context).size.width / 3,
                                  disabledColor:
                                      Color.fromARGB(255, 194, 167, 101),
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => DataChart(
                                              dataForPlot: dataForPlot,
                                              characteristic: characteristic))),
                                  child: Text(
                                    'DATA CHART VISUALIZATION',
                                    style: GoogleFonts.catamaran(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 12,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              36,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
                            ],
                          ),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              padding: EdgeInsets.symmetric(
                                  vertical: screen_height / 100,
                                  horizontal: screen_width / 8),
                              color: Color.fromARGB(255, 9, 211,
                                  9), //245, 23, 81, 123, 81 //255, 211, 117, 9
                              minWidth: MediaQuery.of(context).size.width / 3,
                              disabledColor: Color.fromARGB(255, 194, 167, 101),
                              onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      elevation: 10,
                                      title: Text('ATTENTION',
                                          style: GoogleFonts.catamaran(
                                            textStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 1, 38, 68)),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                          )),
                                      content: Text(
                                          'Are you sure you want to delete CSV data?',
                                          style: GoogleFonts.catamaran(
                                            textStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 1, 38, 68)),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => clearData(dataForCSV,
                                              dataForPlot, context, time),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                              child: Text(
                                '  CLEAR CSV DATA  ',
                                style: GoogleFonts.catamaran(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              36,
                                      fontWeight: FontWeight.w700),
                                ),
                              )),

                          //Text(''),
                        ]));
                      })
                ],
              )
            ],
          ),
        )));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 1, 38, 68),
      title: Text("Data visualization",
          style: GoogleFonts.catamaran(
            textStyle: TextStyle(color: Colors.white),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}

int returnInteger(List<int> data) {
  int converted = 0;
  for (var i = 0, length = 4; i < length; i++) {
    converted += data[i] * (pow(256, i) as int);
  }
  return converted;
}

void clearData(
    List<List<String>> data1, List<ChartData> data2, context, int time) {
  CSV_count = 0;
  data1.clear();
  data1 = [
    ['Time', 'CO2 Value']
  ];
  data2.clear();
  time = 0;
  Navigator.pop(context, 'Cancel');
}

void exportCSV(BuildContext context) {
  CSV_count = CSV_count + 1;
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ExportCSV(
            dataForCSV: dataForCSV,
            date: formattedDate_export,
            CSV_count: CSV_count,
          )));
}

//OCRA: 251, 188, 88
//BLU: 9, 93, 106


//TODO: fix bug when passing data to exportCSV and dataChart screens.
//Quando premo il bottone DATA VISUALIZATION salvare il primo valore e 
//poi controllare quando viene riletto per saltare quella lettura e corrompere
//il CSV e il plot