import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:smartaudience/src/bloc/validators.dart';

class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del stream
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  //validar los campos llenados y habilitar el boton
  Stream<bool> get formValidStream =>
    Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // INSERTAR VALORES AL STREAM
  Function( String ) get changeEmail    => _emailController.sink.add;
  Function( String ) get changePassword => _passwordController.sink.add;

  //obtener los ultimos valores emitidos
  String get email     => _emailController.value;
  String get password  => _passwordController.value;

  dispose() {

    _emailController?.close();
    _passwordController?.close();

  }

}