import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FoundDevice extends StatelessWidget {
  final BluetoothDevice device;
  final Function setChosenDevice;

  FoundDevice(this.device, this.setChosenDevice);

  // be able to click "connect", and it connects, then sets chosen device. Maybe
  // have to have one function that returns... a function...?

  void submitChosenDevice() async {
    await device.connect();
    setChosenDevice(device);
  }

  @override
  Widget build(BuildContext context) {
    if (device.name.length > 0) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          color: Colors.deepPurpleAccent,
          constraints: BoxConstraints(minWidth: 350),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  device.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Dis one'),
                onPressed: submitChosenDevice,
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
