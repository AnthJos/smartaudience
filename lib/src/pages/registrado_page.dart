import 'package:flutter/material.dart';

class RegistradoPage extends StatelessWidget {
  const RegistradoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro al taller'),
        backgroundColor: Color.fromRGBO(247, 146, 30, 1),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.check,
                color: Color.fromRGBO(247, 146, 30, 1),
                size: 180.0,
              ),
              SizedBox(height: 20.0,),
              Text('Registrado correctamente', style: TextStyle(fontSize: 20.0),),
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