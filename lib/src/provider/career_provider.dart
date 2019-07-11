import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:smartaudience/src/model/career_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';

class CareerProvider{

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final _prefs = new PreferenciasUsuario();


  Future<List<CareerModel>> cargarCareers() async {

    final url = '$_url/careers.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<CareerModel> careers = new List(); 

    if (decodedData == null) return [];
    if ( decodedData['error'] != null ) return [];
    decodedData.forEach((id, career){
      
      final prodTemp = CareerModel.fromJson(career);
      prodTemp.id = id;

      careers.add(prodTemp);

    });

    return careers;

  }

 

}