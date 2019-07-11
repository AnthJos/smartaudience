import 'dart:convert';

import 'package:smartaudience/src/model/beacon_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';
import 'package:http/http.dart' as http;

class RegistroConferenceBeacon{

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> registrarConferencia( BeaconModel beaconConference ) async {
    final url = '$_url/conferenceregistro/${ _prefs.idCareer }/conference1.json?auth=${ _prefs.token }';
    final resp = await http.post( url, body: beaconModelToJson(beaconConference), );
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;

  }

  Future<int> verificarRegistroConferencia() async {

    final url = '$_url/conferenceregistro/${ _prefs.idCareer }/conference1.json?auth=${ _prefs.token }';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<BeaconModel> registros = new List();
    int respuesta;

    if (decodedData == null) return 0;
    if ( decodedData['error'] != null ) return 0;
    decodedData.forEach((id, registro){
      
      final prodTemp = BeaconModel.fromJson(registro);
        prodTemp.tok = id;

        registros.add(prodTemp);
    });
    for (var i = 0; i < registros.length; i++) {
      print(registros[i].fechaini);
      if(registros[i].id == _prefs.idUser && registros[i].fechafin == ""){
        respuesta = 1;
        break;
      }else if(registros[i].id == _prefs.idUser && registros[i].fechafin != ""){
        respuesta = 2;
        break;
      }else{
        respuesta = 0;
      }
    }

    return respuesta;

  }

}