import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import './foundDevice.dart';

class BluetoothDevicesContainer extends StatelessWidget {
  final List<ScanResult> devices;
  final Function setChosenDevice;

  BluetoothDevicesContainer(this.devices, this.setChosenDevice);

  @override
  Widget build(BuildContext context) {
    if (devices.length < 1) {
      return Text('No devices found');
    } else {
      return new Column(
          children: devices
              .map((item) => new FoundDevice(item.device, setChosenDevice))
              .toList());
    }
  }
}
