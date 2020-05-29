import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DiscoveredCharacteristic extends StatelessWidget {
  final BluetoothCharacteristic characteristic;

  DiscoveredCharacteristic(this.characteristic);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(characteristic.uuid.toString()),
    );
  }
}
