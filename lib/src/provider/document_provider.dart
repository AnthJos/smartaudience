import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:smartaudience/src/model/document_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';

class DocumentProvider{

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final _prefs = new PreferenciasUsuario();
  
  Future<List<DocumentModel>> cargarDocumentos() async {

    final url = '$_url/documents.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<DocumentModel> documentos = new List(); 

    if (decodedData == null) return [];
    if ( decodedData['error'] != null ) return [];
    decodedData.forEach((id, documento){
      
      final prodTemp = DocumentModel.fromJson(documento);
      prodTemp.id = id;

      documentos.add(prodTemp);

    });

    return documentos;

  }

}