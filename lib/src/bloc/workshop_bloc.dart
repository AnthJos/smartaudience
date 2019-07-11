
import 'package:rxdart/rxdart.dart';

import 'package:smartaudience/src/model/workshop_model.dart';
import 'package:smartaudience/src/provider/workshop_provider.dart';

class WorkshopBloc {

  final _workshopController = new BehaviorSubject<List<WorkshopModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _workshopProvider = new WorkshopProvider();

  Stream<List<WorkshopModel>> get workshopStream => _workshopController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarWorkshops() async {

    final workshops = await _workshopProvider.cargarWorkshops();
      _workshopController.sink.add(workshops);

  }

  dispose(){

    _workshopController?.close();
    _cargandoController?.close();

  }

}