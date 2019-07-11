import 'package:flutter/material.dart';
import 'package:smartaudience/src/bloc/provider.dart';

class DatosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userBloc = Provider.userBloc(context);
      userBloc.cardaData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Datos'),
        backgroundColor: Color.fromRGBO(247, 146, 30, 1),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Colors.black12,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                'Información de usuario',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            StreamBuilder(
              stream: userBloc.userStream,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                final data = snapshot.data;
                if( snapshot.hasData ){
                  return Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.person_outline, color: Color.fromRGBO(247, 146, 30, 1),),
                          title: Text(data['name']),
                        ),
                        Divider(color: Colors.black12,),
                        ListTile(
                          leading: Icon(Icons.email, color: Color.fromRGBO(247, 146, 30, 1),),
                          title: Text(data['email']),
                        )
                      ],
                    ),
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            ),
            Container(
              width: double.infinity,
              color: Colors.black12,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                'Contraseña',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Color.fromRGBO(247, 146, 30, 1)),
              title: Text('Cambia tu contraseña'),
              onTap: (){
                cambiarPassword(context);
              },
            ),
            Container(
              width: double.infinity,
              color: Colors.black12,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                'Tu nueva contraseña es : ',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void cambiarPassword( BuildContext context ){

    showDialog(
      context: context,
      builder: ( context ){
        return AlertDialog(
          title: Text('Cambia tu contraseña'),
          content: Container(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa tu nueva contraseña'
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    );

  }

}