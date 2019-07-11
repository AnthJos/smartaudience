import 'package:flutter/material.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';
import 'package:smartaudience/src/provider/workshop_registro.dart';

class VerificarRegistoPage extends StatelessWidget {

  final workshopRegistro = WorkshopRegistro();
  final _prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Color.fromRGBO(247, 146, 30, 1),
      ),
      body: FutureBuilder(
        future: workshopRegistro.verificarTaller(),
        builder: (c, snapshot){
          final data = snapshot.data;
          print(data);
          if( data != null && data == _prefs.idUser){
            return Container(
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
            );
          }else if ( data != null && data != _prefs.idUser ){
            return Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.close,color: Colors.green,size: 150.0,),
                    SizedBox(height: 20.0,),
                    Text(
                      'El usuario no está registrado en este taller', 
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
            );
          }else{
            return Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.close,color: Colors.green,size: 150.0,),
                    SizedBox(height: 20.0,),
                    Text(
                      'El usuario no está registrado en este taller', 
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
            );
          }
        },
      )
      
      
    );
  }
}