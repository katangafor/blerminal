import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import './discoveredService.dart';

class ChosenDevice extends StatefulWidget {
  final BluetoothDevice device;
  final Function setChosenDevice;
  final Function setChosenCharacteristic;

  ChosenDevice(this.device, this.setChosenDevice, this.setChosenCharacteristic);

  @override
  _ChosenDeviceState createState() => _ChosenDeviceState();
}

class _ChosenDeviceState extends State<ChosenDevice> {
  var _discoveredServices = <BluetoothService>[];

  void disconnectFromDevice() {
    widget.device.disconnect();
    widget.setChosenDevice(null);
  }

  void discoverServices() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    setState(() {
      _discoveredServices = services;
    });
  }

  void makeAndPrintTime() {
    var now = new DateTime.now();
    var hour = now.hour.toString();
    var minute = now.minute.toString();
    var second = now.second.toString();
    if (now.hour < 10) {
      hour = '0' + hour;
    }
    if (now.minute < 10) {
      hour = '0' + minute;
    }
    if (now.second < 10) {
      second = '0' + second;
    }

    print(now.toString());
    print('${now.hour} --- ${hour}');
    print('${now.minute} --- ${minute}');
    print('${now.second} --- ${second}');
    print('SET_TIME${hour}${minute}${second}');
    print('');
  }

  Widget returnText() {
    return Text('maddie');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.device.name.length > 0) {
      return ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                child: Text('${widget.device.name}',
                    style: TextStyle(fontSize: 35, color: Colors.white)),
                padding: EdgeInsets.all(5)),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    child: Text('Disconnect'), onPressed: disconnectFromDevice),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    child: Text('Discover services'),
                    onPressed: discoverServices),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Services',
                style: TextStyle(color: Colors.white, fontSize: 30),
              )),
          ..._discoveredServices
              .map(
                (service) => new DiscoveredService(
                    service, widget.setChosenCharacteristic),
              )
              .toList(),
          RaisedButton(
              child: Text('make and print time'), onPressed: makeAndPrintTime)
        ],
      );
    } else {
      return Container(
          // child: Text('No name', style: TextStyle(fontSize: 15)),
          );
    }
  }
}
