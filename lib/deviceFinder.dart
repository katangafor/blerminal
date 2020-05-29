import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

import './bluetoothDevicesContainer.dart';

class DeviceFinder extends StatelessWidget {
  final Function setClock;
  final Function setBluetoothDevices;
  DateTime chosenTime;
  List<ScanResult> bluetoothDevices;
  final Function setChosenDevice;

  DeviceFinder(this.setClock, this.setBluetoothDevices, this.chosenTime,
      this.bluetoothDevices, this.setChosenDevice);

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  var subscription;

  void startScanning() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    subscription = flutterBlue.scanResults.listen((scanResults) {
      setBluetoothDevices(scanResults);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('¯\\_(ツ)_/¯')),
        body: ListView(
          children: <Widget>[
            Text(chosenTime.toString(),
                style: new TextStyle(fontSize: 25, color: Colors.blue)),
            RaisedButton(
                child: Text('Start da scan ya dummy',
                    style: TextStyle(fontSize: 20)),
                onPressed: startScanning),
            BluetoothDevicesContainer(bluetoothDevices, setChosenDevice)
          ],
        ),
      ),
    );
  }
}
