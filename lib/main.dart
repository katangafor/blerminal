import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

import './deviceFinder.dart';
import './chosenDevice.dart';
import './chosenCharacteristic.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _chosenTime = new DateTime.now();
  var _bluetoothDevices = <ScanResult>[];
  var _chosenDevice;
  var _chosenService;
  var _chosenCharacteristic;

  void setClock(DateTime value) {
    setState(() {
      _chosenTime = value;
    });
  }

  void setBluetoothDevices(List<ScanResult> scanResults) {
    setState(() {
      _bluetoothDevices = scanResults;
    });
  }

  void setChosenDevice(BluetoothDevice device) {
    setState(() {
      _chosenDevice = device;
    });
  }

  void setChosenService(BluetoothService service) {
    setState(() {
      _chosenService = service;
    });
  }

  void setChosenCharacteristic(BluetoothCharacteristic characteristic) {
    setState(() {
      _chosenCharacteristic = characteristic;
    });
  }

  void printDevices() {
    for (ScanResult result in _bluetoothDevices) {
      print('Found (${result.device.name}) of number (${result.rssi})');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_chosenDevice == null) {
      return DeviceFinder(setClock, setBluetoothDevices, _chosenTime,
          _bluetoothDevices, setChosenDevice);
    } else if (_chosenCharacteristic == null) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.deepPurpleAccent,
          appBar: AppBar(title: Text('yea')),
          body: ChosenDevice(
              _chosenDevice, setChosenDevice, setChosenCharacteristic),
        ),
      );
    } else {
      return MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.deepPurpleAccent,
              appBar: AppBar(title: Text('char bbe')),
              body: ChosenCharacteristic(
                  _chosenCharacteristic, setChosenCharacteristic)));
    }
  }
}
