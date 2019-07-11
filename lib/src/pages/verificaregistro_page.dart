import 'package:flutter/material.dart';

class VerificarRegistoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Color.fromRGBO(247, 146, 30, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(Icons.verified_user,color: Colors.green,size: 150.0,),
              SizedBox(height: 20.0,),
              Text(
                'El usuario si está registrado en este taller', 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0,),
              FlatButton(
                child: Text('MENÚ PRINCIPAL'),
                color: Color.fromRGBO(247, 146, 30, 1),
                textColor: Colors.white,
                onPressed: () => Navigator.pushReplacementNamed(context, 'menu'),
              )
            ],
          ),
        ),
      ),
    );
  }
}