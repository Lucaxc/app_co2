import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:PtCO2/DataVisualization.dart';
import 'package:PtCO2/exportCSV.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:wakelock/wakelock.dart';

int CO2_Data_chart = 0;
List<ChartData> dataForPlot2 = [];
ChartData CO2_for_plot2 = ChartData(0, 0);

class DataChart extends StatelessWidget {
  final List<ChartData> dataForPlot;
  final BluetoothCharacteristic characteristic;

  const DataChart(
      {Key? key, required this.dataForPlot, required this.characteristic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: Container(
            child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text('Measured CO2 value',
                    style: GoogleFonts.catamaran(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    )),
                //Text(''),
                StreamBuilder<List<int>>(
                    stream: characteristic.value,
                    initialData: characteristic.lastValue,
                    builder: (c, snapshot) {
                      final value = snapshot.data;
                      CO2_Data_chart = returnInteger(value as List<int>);
                      double C02_Data_2_double2 = CO2_Data_chart.toDouble();
                      time = time + 1;
                      CO2_for_plot2 = ChartData(time, C02_Data_2_double2);
                      dataForPlot2.add(CO2_for_plot);

                      return Container(
                          child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(CO2_Data_chart.toString(),
                                  style: GoogleFonts.catamaran(
                                    textStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 26, 201, 19)),
                                    fontSize: 70,
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
                            ]),
                        Container(
                          child: SfCartesianChart(series: <ChartSeries>[
                            // Renders line chart
                            LineSeries<ChartData, int>(
                                dataSource: dataForPlot2,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y)
                          ]),
                        ),
                        Text(''),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            padding: EdgeInsets.symmetric(
                                vertical: screen_height / 100,
                                horizontal: screen_width / 8),
                            color: Color.fromARGB(255, 9, 56, 211),
                            minWidth: MediaQuery.of(context).size.width / 3,
                            disabledColor: Color.fromARGB(255, 194, 167, 101),
                            onPressed: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ExportCSV(
                                          dataForCSV: dataForCSV,
                                          date: formattedDate,
                                          CSV_count: CSV_count,
                                        ))),
                            child: Text(
                              '  EXPORT CSV  ',
                              style: GoogleFonts.catamaran(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                      ]));
                    }),

                Container(width: MediaQuery.of(context).size.width / 15),
              ])),
        )));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 1, 38, 68),
      title: Text("Data chart",
          style: GoogleFonts.catamaran(
            textStyle: TextStyle(color: Colors.white),
            fontSize: 23,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
