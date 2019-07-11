import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:smartaudience/src/model/conference_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';

class ConferenceProvider{

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final _prefs = new PreferenciasUsuario();


  Future<List<ConferenceModel>> cargarConferences() async {

    final url = '$_url/conferences/${ _prefs.idCareer }.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ConferenceModel> conferences = new List(); 

    if (decodedData == null) return [];
    if ( decodedData['error'] != null ) return [];
    decodedData.forEach((id, conference){
      
      final prodTemp = ConferenceModel.fromJson(conference);
      prodTemp.id = id;

      conferences.add(prodTemp);

    });

    return conferences;

  }

  Future<int> verificarConferencia() async{

    final List<ConferenceModel> conferences = await cargarConferences();
    
    if ( conferences.length > 0 ){
      return 1;
    }else{
      return 0;
    }

  }

 

}