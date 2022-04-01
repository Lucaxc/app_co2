//Layout for data printing from DataVisualization

import 'package:PtCO2/DataVisualization.dart';
import 'package:PtCO2/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue/flutter_blue.dart';

class visual extends StatelessWidget {
  final BluetoothDevice device;
  final BluetoothService service;
  final BluetoothCharacteristic characteristic;
  //final int data0;
  //final int data1;
  //final int data2;

  const visual({
    Key? key,
    required this.device,
    required this.service,
    required this.characteristic,
    //required this.data0,
    //required this.data1,
    //required this.data2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            appBar: buildAppBar(),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Spacer(),
                        Text('Measured CO2 value',
                            style: GoogleFonts.catamaran(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 1, 38, 68)),
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
                                        color:
                                            Color.fromARGB(255, 26, 201, 19)),
                                    fontSize: 50,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(' ppm',
                                  style: GoogleFonts.catamaran(
                                    textStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 26, 201, 19)),
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
                                    textStyle: TextStyle(
                                        color: Color.fromARGB(255, 1, 38, 68)),
                                    fontSize: 50,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(' ppm',
                                  style: GoogleFonts.catamaran(
                                    textStyle: TextStyle(
                                        color: Color.fromARGB(255, 1, 38, 68)),
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
                                    textStyle: TextStyle(
                                        color: Color.fromARGB(255, 1, 38, 68)),
                                    fontSize: 50,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(' ppm',
                                  style: GoogleFonts.catamaran(
                                    textStyle: TextStyle(
                                        color: Color.fromARGB(255, 1, 38, 68)),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ],
                          ),
                        ),
                        //Spacer(flex: 500),

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
                    )
                  ]),
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
