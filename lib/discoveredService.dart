import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DiscoveredService extends StatelessWidget {
  final BluetoothService service;
  final Function setChosenCharacteristic;

  DiscoveredService(this.service, this.setChosenCharacteristic);

  void readChars() async {
    var characteristics = service.characteristics;
    for (BluetoothCharacteristic c in characteristics) {
      List<int> value = await c.read();
      print(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: 900,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(1),
              child: Text(
                'Service ID:',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                service.uuid.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Characteristic ID\'s:',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            ...service.characteristics.map(
              (char) => Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        char.uuid.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Writable: ${char.properties.write}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Readable: ${char.properties.read}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Listenable: ${char.properties.notify}',
                        style: TextStyle(color: Colors.white),
                      ),
                      RaisedButton(
                          child: Text('Select'),
                          onPressed: () {
                            setChosenCharacteristic(char);
                          })
                    ],
                  )),
            ),
            RaisedButton(child: Text('print chars stuff'), onPressed: readChars)
          ],
        ),
      ),
    );
  }
}
