import 'package:flutter/material.dart';
import 'package:smartaudience/src/bloc/provider.dart';
import 'package:smartaudience/src/pages/beacon_page.dart';
import 'package:smartaudience/src/pages/conferencia_close.dart';
import 'package:smartaudience/src/pages/datos_page.dart';
import 'package:smartaudience/src/pages/detalle_conferencia.dart';
import 'package:smartaudience/src/pages/detalle_taller.dart';
import 'package:smartaudience/src/pages/document_page.dart';
import 'package:smartaudience/src/pages/quest_page.dart';
import 'package:smartaudience/src/pages/registrado_page.dart';
import 'package:smartaudience/src/pages/registro_beacon.dart';
import 'package:smartaudience/src/pages/sesion_close.dart';


import 'src/pages/home_page.dart';
import 'package:smartaudience/src/pages/login_page.dart';
import 'package:smartaudience/src/pages/menu_page.dart';
import 'package:smartaudience/src/pages/verificaregistro_page.dart';

import 'package:smartaudience/src/preferences/preferences_usuario.dart';

 
void main() async {

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());

} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    print( '-- '+ prefs.passwordUser + '--'+ prefs.correoUser +' -- '+ prefs.token );

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Audience',
        initialRoute: 'login',
        routes: {
          'login'     : ( BuildContext context ) => LoginPage(),
          'home'      : ( BuildContext context ) => HomePage(),
          'menu'      : ( BuildContext context ) => MenuPage(),
          'datos'     : ( BuildContext context ) => DatosPage(),
          'verificarRegistro' : ( BuildContext context ) => VerificarRegistoPage(),
          'detalleConference' : ( BuildContext context ) => DetalleConferencia(),
          'detalleTaller'     : ( BuildContext context ) => DetalleTaller(),
          'registradoPage'    : ( BuildContext context ) => RegistradoPage(),
          'beaconPage'        : ( BuildContext context ) => BeaconPage(),
          'registroBeacon'    : ( BuildContext context ) => RegistroBeacon(),
          'sesionClose'       : ( BuildContext context ) => SsesionClose(),
          'documento'         : ( BuildContext context ) => DocumentPage(),
          'quest'             : ( BuildContext context ) => QuestPage(),
          'registroSalida'    : ( BuildContext context ) => RegistroSalidaConferencia()
        },
      ),
    );
  }
}