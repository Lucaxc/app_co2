import 'package:PtCO2/DataVisualization.dart';
import 'package:PtCO2/Visual_test.dart';
import 'package:PtCO2/Visual_test.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PtCO2/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:math';

List<List<int>> value2 = [];
List<int> results = [];
BluetoothDevice dummy_device = 'dummy_device' as BluetoothDevice;
BluetoothService dummy_service = 'dummy_service' as BluetoothService;
BluetoothCharacteristic dummy_characteristic =
    'dummy_characteristic' as BluetoothCharacteristic;

bool flag_connected = false;
bool flag_sync = false;

class DevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 38, 68),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(flex: 2),
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Spacer(),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}',
              style: GoogleFonts.catamaran(
                textStyle: TextStyle(color: Colors.white),
                fontSize: 23,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      padding: const EdgeInsets.all(5),
                                      color: Color.fromARGB(255, 52, 251, 45),
                                      minWidth: 100.0,
                                      disabledColor:
                                          Color.fromARGB(255, 194, 167, 101),
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  DeviceScreen(device: d))),
                                      child: Text(
                                        'OPEN',
                                        style: GoogleFonts.catamaran(
                                          textStyle: TextStyle(
                                              color: Color(0xFF1A237E),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ));

                                  /*RaisedButton(
                                    child: Text('OPEN'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeviceScreen(device: d))),
                                  );*/
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

//To do: data acquisition and visualization from here
class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  /*List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }*/

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    dummy_device = device;
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write([0, 0]);
                    },
                    onNotificationPressed: () async {
                      flag_sync = true;
                      await c.setNotifyValue(!c.isNotifying);
                      //TODO: read again the value of the notifying bool to check when to stop acquisition
                      dummy_characteristic = c;
                      dummy_service = s;
                      print('+++++++++++++++++++++++++++++++++');
                      //cercare di capire come stampare sti cosi maledetti
                      print(dummy_characteristic);
                      print(dummy_service);
                      print(dummy_device);
                      print('+++++++++++++++++++++++++++++++++');
                      //() => readCharacteristic(c),

                      /*Check what is happening with the lines here below*/
                      List<int> value1 = await c.read();
                      int result = returnInteger(value1);
                      results.add(result);
                      value2.add(value1);
                      /******************************************/
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write([1, 1]),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 38, 68),
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => checkDisconnection(device);
                  //device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () => //device.discoverServices(),
                              checkConnection(device)),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data!),
                );
              },
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                padding: const EdgeInsets.all(5),
                color: Color(0xFFFBC02D),
                minWidth: 300.0,
                disabledColor: Color.fromARGB(255, 194, 167, 101),
                onPressed: () => changeScreen(context),
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataVisualization(
                            device: dummy_device,
                            service: dummy_service,
                            characteristic: dummy_characteristic))),*/
                child: Text(
                  'DATA VISUALIZATION',
                  style: GoogleFonts.catamaran(
                    textStyle: TextStyle(
                        color: Color(0xFF1A237E),
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

//Function that returns an integer from an array of bytes
int returnInteger(List<int> data) {
  int converted = 0;
  for (var i = 0, length = 4; i < length; i++) {
    converted += data[i] * (pow(256, i) as int);
  }
  return converted;
}

void checkConnection(BluetoothDevice device) {
  device.discoverServices();
  flag_connected = true;
}

//Prototype function not used
void chechSynchronization(BluetoothDevice device) {
  flag_sync = true;
}

void changeScreen(BuildContext context) {
  if (flag_connected == true && flag_sync == true) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DataVisualization(
                device: dummy_device,
                service: dummy_service,
                characteristic: dummy_characteristic)));
  } else if (flag_connected == false && flag_sync == false) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        elevation: 10,
        title: Text('ATTENTION',
            style: GoogleFonts.catamaran(
              textStyle: TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            )),
        content: Text(
            'To visualize data, check the connection to the device or if the update button is pressed',
            style: GoogleFonts.catamaran(
              textStyle: TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok'),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  } else if (flag_connected == true && flag_sync == false) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        elevation: 10,
        title: Text('ATTENTION',
            style: GoogleFonts.catamaran(
              textStyle: TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            )),
        content: Text('To visualize data, press the synchronization button',
            style: GoogleFonts.catamaran(
              textStyle: TextStyle(color: Color.fromARGB(255, 1, 38, 68)),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok'),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}

void checkDisconnection(BluetoothDevice device) {
  flag_connected = false;
  flag_sync = false;
  device.disconnect();
}
