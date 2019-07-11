import 'dart:convert';

import 'package:smartaudience/src/model/quest_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';
import 'package:http/http.dart' as http;

class QuestProvider{

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> registrarPreguntas( QuestModel registroPregunta ) async {
    final url = '$_url/questions.json?auth=${ _prefs.token }';
    final resp = await http.post( url, body: questModelToJson(registroPregunta), );
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;

  }

  Future<List<QuestModel>> obtenerPreguntas() async {
    
    final url = '$_url/questions.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<QuestModel> questions = new List();

    if (decodedData == null) return [];
    if ( decodedData['error'] != null ) return [];
    decodedData.forEach((id, quest){
      
      final prodTemp = QuestModel.fromJson(quest);
      prodTemp.id = id;

      questions.add(prodTemp);

    });

    return questions;

  }

}