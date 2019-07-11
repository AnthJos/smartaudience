import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:smartaudience/src/model/workshop_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';

class WorkshopProvider{

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final _prefs = new PreferenciasUsuario();


  Future<List<WorkshopModel>> cargarWorkshops() async {

    final url = '$_url/workshops/${ _prefs.idCareer }.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<WorkshopModel> workshops = new List(); 

    if (decodedData == null) return [];
    if ( decodedData['error'] != null ) return [];
    decodedData.forEach((id, workshop){
      
      final prodTemp = WorkshopModel.fromJson(workshop);
      prodTemp.id = id;

      workshops.add(prodTemp);

    });

    return workshops;

  }

 

}