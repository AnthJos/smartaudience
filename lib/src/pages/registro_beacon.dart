import 'package:flutter/material.dart';

class RegistroBeacon extends StatefulWidget {
  const RegistroBeacon({Key key}) : super(key: key);

  @override
  _RegistroBeaconState createState() => _RegistroBeaconState();
}

class _RegistroBeaconState extends State<RegistroBeacon> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.bluetooth_connected,
                size: 200.0,
                color: Colors.white54,
              ),
              SizedBox(height: 5.0,),
              Text("Beacon estimote conectado!!", style: TextStyle(color: Colors.white, fontSize: 16.0)),
              SizedBox(height: 5.0,),
              RaisedButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'home');
                },
                color: Color.fromRGBO(247, 146, 30, 1),
                child: Text('Ir al menú principal'),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}