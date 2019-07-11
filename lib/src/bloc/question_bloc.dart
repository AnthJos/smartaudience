import 'package:rxdart/rxdart.dart';
import 'package:smartaudience/src/model/quest_model.dart';
import 'package:smartaudience/src/provider/quest_provider.dart';

class QuestionBloc{

  final _questionController = new BehaviorSubject<List<QuestModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _questionProvider = new QuestProvider();

  Stream<List<QuestModel>> get questionStream => _questionController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarQuestion() async {

    final question = await _questionProvider.obtenerPreguntas();
    _questionController.sink.add(question);

  }

  dispose(){

    _questionController?.close();
    _cargandoController?.close();

  }

}