import 'package:rxdart/rxdart.dart';
import 'package:smartaudience/src/provider/usuario_provider.dart';


class UserBloc{

  final _userController = new BehaviorSubject<Map<String, dynamic>>();

  final _usuarioProvider = new UsuarioProvider();

  Stream<Map<String, dynamic>> get userStream => _userController.stream;

  void cardaData() async {

    final datos = await _usuarioProvider.misDatos();
      _userController.sink.add(datos);

  }

  dispose(){
    _userController?.close();
  }

}