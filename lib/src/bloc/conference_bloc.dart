
import 'package:rxdart/rxdart.dart';

import 'package:smartaudience/src/model/conference_model.dart';
import 'package:smartaudience/src/provider/conference_provider.dart';

class ConferenceBloc {

  final _conferenceController = new BehaviorSubject<List<ConferenceModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _conferenceProvider = new ConferenceProvider();

  Stream<List<ConferenceModel>> get conferenceStream => _conferenceController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarConferences() async {

    final conferences = await _conferenceProvider.cargarConferences();
      _conferenceController.sink.add(conferences);

  }

  dispose(){

    _conferenceController?.close();
    _cargandoController?.close();

  }

}