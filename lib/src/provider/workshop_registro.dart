import 'dart:convert';

import 'package:smartaudience/src/model/workshop_registro_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';
import 'package:http/http.dart' as http;

class WorkshopRegistro{

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final _prefs = new PreferenciasUsuario();


  Future<bool> registrarTaller( WorkshopRegisterModel registrotaller ) async {
    final url = '$_url/workshopregistro/${ _prefs.idCareer }/${ _prefs.idTaller }.json?auth=${ _prefs.token }';
    final resp = await http.post( url, body: workshopRegisterModelToJson(registrotaller), );
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;

  }

  Future<int> obtener() async {

    final url = '$_url/workshopregistro/${ _prefs.idCareer }/${ _prefs.idTaller }.json?auth=${ _prefs.token }';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    if( decodedData == null ) return 0;
    int cantidad = decodedData.length;

    return cantidad;

  }

  Future<String> verificarTaller() async {

    final url = '$_url/workshopregistro/${ _prefs.idCareer }/${ _prefs.idTaller }.json?auth=${ _prefs.token }';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<WorkshopRegisterModel> registros = new List();
    String respuesta = "null";

    if (decodedData == null) return respuesta;
    if ( decodedData['error'] != null ) return respuesta;
    decodedData.forEach((id, registro){
      
      final prodTemp = WorkshopRegisterModel.fromJson(registro);
        prodTemp.tok = id;

        registros.add(prodTemp);
    });

    for (var i = 0; i < registros.length; i++) {
      if( registros[i].iduser  == _prefs.idUser){
        respuesta = registros[i].iduser;
        break;
      }
      
    }

    return respuesta;

  }

}