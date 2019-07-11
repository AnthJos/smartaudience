import 'dart:convert';

import 'package:smartaudience/src/model/workshop_registro_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';
import 'package:http/http.dart' as http;

class WorkshopRegistro{

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> registrarTaller( WorkshopRegisterModel registrotaller ) async {
    final url = '$_url/workshopregistro/${ _prefs.idTaller }.json?auth=${ _prefs.token }';
    final resp = await http.post( url, body: workshopRegisterModelToJson(registrotaller), );
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;

  }

  Future<int> obtener() async {

    final url = '$_url/workshopregistro/${ _prefs.idTaller }.json?auth=${ _prefs.token }';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    int cantidad = decodedData.length;

    return cantidad;

  }

}