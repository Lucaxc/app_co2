//This screen is used to test the widget positioning and understand if the layout for the
//Data visualization is working without returning anything to StreamBuilder

import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

import 'package:app_co2/DevicesScreen.dart';
import 'package:app_co2/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:async';
import 'dart:convert' show utf8;
import 'package:clock/clock.dart';

class time {
  time(this.time_value);

  Uint8 time_value;
}

int CO2Data_0 = 0;
int CO2Data_1 = 0;
int CO2Data_2 = 0;
List<int> CO2_array = [];
final List<int> charCodes = const [97, 98, 99, 100];
//List<int> value = [];

class Visual_test extends StatelessWidget {
  final BluetoothDevice device;
  final BluetoothService service;
  final BluetoothCharacteristic characteristic;

  const Visual_test(
      {Key? key,
      required this.device,
      required this.service,
      required this.characteristic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                StreamBuilder<List<int>>(
                    stream: characteristic.value,
                    initialData: characteristic.lastValue,
                    builder: (c, snapshot) {
                      final value = snapshot.data;
                      CO2Data_0 = CO2Data_1;
                      CO2Data_1 = CO2Data_2;
                      CO2Data_2 = returnInteger(value as List<int>);
                      //CO2_array.add(CO2Data);
                      //print(CO2_array);
                      return const SizedBox.shrink();
                    })
              ]),
              Spacer(),
              Text('Measured CO2 value',
                  style: GoogleFonts.catamaran(
                    textStyle: TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  )),
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${CO2Data_2}', //CO2Data_0.toString(),
                        style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 26, 201, 19)),
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(' ppm',
                        style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 26, 201, 19)),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${CO2Data_1}', //CO2Data_0.toString(),
                        style: GoogleFonts.catamaran(
                          textStyle:
                              TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(' ppm',
                        style: GoogleFonts.catamaran(
                          textStyle:
                              TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${CO2Data_0}', //CO2Data_0.toString(),
                        style: GoogleFonts.catamaran(
                          textStyle:
                              TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(' ppm',
                        style: GoogleFonts.catamaran(
                          textStyle:
                              TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ))
                  ],
                ),
              ),
              Spacer(flex: 500),

              //Insert plot
              /*SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'CO2 collected data'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //Initialize the spark charts widget
                  child: SfSparkLineChart.custom(
                    //Enable the trackball
                    trackball: SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    xValueMapper: (int index) => data[index].year,
                    yValueMapper: (int index) => data[index].sales,
                    dataCount: 5,
                  ),
                ),
              )*/
            ],
          ),
        ));
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
