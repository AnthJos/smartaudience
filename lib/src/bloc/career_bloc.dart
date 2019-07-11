
import 'package:rxdart/rxdart.dart';


import 'package:smartaudience/src/model/career_model.dart';
import 'package:smartaudience/src/provider/career_provider.dart';

class CareerBloc {

  final _careersController = new BehaviorSubject<List<CareerModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _careerProvider = new CareerProvider();

  Stream<List<CareerModel>> get careersStream => _careersController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarCareers() async {

    final careers = await _careerProvider.cargarCareers();
    _careersController.sink.add( careers );

  }


  dispose(){

    _careersController?.close();
    _cargandoController?.close();

  }

}