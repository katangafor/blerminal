import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';

class ChosenCharacteristic extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final Function setChosenCharacteristic;

  ChosenCharacteristic(this.characteristic, this.setChosenCharacteristic);

  @override
  _ChosenCharacteristicState createState() => _ChosenCharacteristicState();
}

class _ChosenCharacteristicState extends State<ChosenCharacteristic> {
  var receivedValue = '';
  var decoder = new AsciiCodec();
  var controller = TextEditingController();

  void clearReceivedValue() {
    setState(() {
      receivedValue = '';
    });
  }

  void unchooseCharacteristic() {
    widget.setChosenCharacteristic(null);
  }

  void getDescriptorValues() async {
    var descriptors = widget.characteristic.descriptors;
    for (BluetoothDescriptor d in descriptors) {
      List<int> value = await d.read();
      print(value);
    }
  }

  void read() async {
    var value = await widget.characteristic.read();
    print(value);
    setState(() {
      receivedValue = decoder.decode(value);
    });
  }

  void write() async {
    var encodedString = decoder.encode(controller.text);
    var response = await widget.characteristic.write(encodedString);
    print('tried to send ${encodedString}');
    print(response);
  }

  void sendTime() async {
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
    print('');

    var encodedString = decoder.encode('SET_TIME${hour}${minute}${second}');
    var response = await widget.characteristic.write(encodedString);
    print(response);
  }

  void listen() async {
    await widget.characteristic.setNotifyValue(true);
    widget.characteristic.value.listen((value) {
      var newValue = receivedValue + decoder.decode(value);
      setState(() {
        receivedValue = newValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Characteristic ID:',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            widget.characteristic.uuid.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        RaisedButton(
            child: Text('Back to services'), onPressed: unchooseCharacteristic),
        RaisedButton(child: Text('start listening'), onPressed: listen),
        RaisedButton(child: Text('read value'), onPressed: read),
        RaisedButton(
            child: Text('clear recieved values'),
            onPressed: clearReceivedValue),
        RaisedButton(
            child: Text('print recieved values'),
            onPressed: () {
              print(receivedValue);
            }),
        RaisedButton(child: Text('send time'), onPressed: sendTime),
        Container(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                receivedValue,
                style: TextStyle(fontSize: 20),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                RaisedButton(
                  onPressed: write,
                  child: Text('submit'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
