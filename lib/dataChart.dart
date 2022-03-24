import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:app_co2/DataVisualization.dart';
import 'package:app_co2/exportCSV.dart';

class DataChart extends StatelessWidget {
  final List<ChartData> dataForPlot;

  const DataChart({Key? key, required this.dataForPlot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: Container(
            child: Center(
          child: SingleChildScrollView(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text('Measured CO2 value',
                    style: GoogleFonts.catamaran(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
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
                                color: Color.fromARGB(255, 26, 201, 19)),
                            fontSize: 70,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(' ppm',
                          style: GoogleFonts.catamaran(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 26, 201, 19)),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ))
                    ]),
                Container(
                  child: SfCartesianChart(series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<ChartData, int>(
                        dataSource: dataForPlot,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ]),
                ),
                Text(''),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
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
