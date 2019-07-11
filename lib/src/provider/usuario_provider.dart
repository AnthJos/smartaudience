import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:smartaudience/src/preferences/preferences_usuario.dart';

class UsuarioProvider {

  final String _url = 'https://smart-audience-6a6e1.firebaseio.com';
  final String _firebaseToken = 'AIzaSyBpC3c9HFChMsgydW9BMkBOXleyVsZ42Pg';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login( String email, String password ) async {

    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_firebaseToken',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );


    if( decodedResp.containsKey('idToken') ){
      _prefs.token = decodedResp['idToken'];
      _prefs.idUser = decodedResp['localId'];

      return { 'ok': true, 'token': decodedResp['idToken'] };
    }else{
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }

  }

  Future<Map<String, dynamic>> misDatos() async {

    final url = '$_url/users/${ _prefs.idUser }.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return {};

    if ( decodedData['error'] != null ) return {};

    
    print(decodedData);

    return decodedData;

  }

}