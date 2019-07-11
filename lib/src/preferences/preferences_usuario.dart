import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }

  // GET y SET del id del usuario
  get idUser {
    return _prefs.getString('localId') ?? '';
  }

  set idUser( String value ) {
    _prefs.setString('localId', value);
  }
  // GET y SET del id de la Carrera
  get idCareer {
    return _prefs.getString('careerId') ?? '';
  }

  set idCareer( String value ) {
    _prefs.setString('careerId', value);
  }
  // Get y Set del correo del usuario
  get correoUser {
    return _prefs.getString('correoUser') ?? '';
  }
  set correoUser( String value ){
    _prefs.setString('correoUser', value);
  }
  // Get y Set del password del usuario
  get passwordUser {
    return _prefs.getString('passwordUser') ?? '';
  }
  set passwordUser( String value ){
    _prefs.setString('passwordUser', value);
  }
  
  // Get y Set del password del usuario
  get idTaller {
    return _prefs.getString('idTaller') ?? '';
  }
  set idTaller( String value ){
    _prefs.setString('idTaller', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}

