import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  final String SERVICE_UUID = "9c3a81f8-13a2-47ca-b6c1-e246c6301560";
  final String CHARACTERISTIC_UUID = "ff469246-6e68-468b-935b-f7e4c6604897";
  bool isReady = false;
  Stream<List<int>>? stream;
  List<double> traceDust = [];

  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
  }

  connectToDevice() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    new Timer(const Duration(seconds: 15), () {
      if (!isReady) {
        disconnectFromDevice();
        _Pop();
      }
    });

    await widget.device.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _Pop();
      return;
    }

    widget.device.disconnect();
  }

  discoverServices() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;

            setState(() {
              isReady = true;
            });
          }
        });
      }
    });

    if (!isReady) {
      _Pop();
    }
  }

  Text _onWillPop() {
    return const Text(
        "debug"); /*showDialog(
        context: context,
        builder: (context) =>
            new AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to disconnect device and go back?'),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No')),
                new FlatButton(
                    onPressed: () {
                      disconnectFromDevice();
                      Navigator.of(context).pop(true);
                    },
                    child: new Text('Yes')),
              ],
            ) ??
            false);*/
  }

  _Pop() {
    Navigator.of(context).pop(true);
  }

  String _dataParser(List<int>? dataFromDevice) {
    return utf8.decode(dataFromDevice as List<int>);
  }

  @override
  Widget build(BuildContext context) {
    /*Oscilloscope oscilloscope = Oscilloscope(
      showYAxis: true,
      padding: 0.0,
      backgroundColor: Colors.black,
      traceColor: Colors.white,
      yAxisMax: 3000.0,
      yAxisMin: 0.0,
      dataSet: traceDust,
    );*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 38, 68),
        title: Text("Found devices",
            style: GoogleFonts.catamaran(
              textStyle: TextStyle(color: Colors.white),
              fontSize: 23,
              fontWeight: FontWeight.w400,
            )),
        /*  actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.update_rounded),
        )
      ],*/
      ),
      body: Container(
          child: !isReady
              ? Center(
                  child: Text(
                    "Waiting...",
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 1, 38, 68)),
                  ),
                )
              : Container(
                  child: StreamBuilder<List<int>>(
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<int>> snapshot) {
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');

                      if (snapshot.connectionState == ConnectionState.active) {
                        var currentValue = _dataParser(snapshot.data);
                        traceDust.add(double.tryParse(currentValue) ?? 0);

                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Current value from Sensor',
                                        style: TextStyle(fontSize: 14)),
                                    Text('${currentValue} ug/m3',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24))
                                  ]),
                            ),
                            Spacer(
                              flex: 1,
                              //child: oscilloscope,
                            )
                          ],
                        ));
                      } else {
                        return Text('Check the stream');
                      }
                    },
                  ),
                )),
    );
  }
}
