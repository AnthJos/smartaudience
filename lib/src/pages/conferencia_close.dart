import 'package:flutter/material.dart';

class RegistroSalidaConferencia extends StatelessWidget {
  const RegistroSalidaConferencia({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.check,
                color: Color.fromRGBO(247, 146, 30, 1),
                size: 180.0,
              ),
              SizedBox(height: 20.0,),
              Text('Sé registró su salida correctamente', style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 20.0,),
              RaisedButton(
                child: Text('Aceptar'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}