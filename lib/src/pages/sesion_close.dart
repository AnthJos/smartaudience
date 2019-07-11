import 'package:flutter/material.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';

class SsesionClose extends StatefulWidget {
  SsesionClose({Key key}) : super(key: key);

  _SsesionCloseState createState() => _SsesionCloseState();
}

class _SsesionCloseState extends State<SsesionClose> {

  final _prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    _prefs.idUser = "";
    _prefs.correoUser = "";
    _prefs.idCareer = "";
    _prefs.token = "";
    _prefs.passwordUser = "";

    Future.delayed(Duration(seconds: 4),(){
      Navigator.pushNamedAndRemoveUntil(context, 'login', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 10.0,),
              Text('Cerrando sesión', style: TextStyle(fontSize: 16.0, color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}