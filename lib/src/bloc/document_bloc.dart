import 'package:rxdart/rxdart.dart';
import 'package:smartaudience/src/model/document_model.dart';
import 'package:smartaudience/src/provider/document_provider.dart';

class DocumentBloc{

  final _documentController = new BehaviorSubject<List<DocumentModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _documentProvider = new DocumentProvider();

  Stream<List<DocumentModel>> get documentStream => _documentController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarDocuments() async {

    final documents = await _documentProvider.cargarDocumentos();
      _documentController.sink.add(documents);

  }

  dispose(){

    _documentController?.close();
    _cargandoController?.close();

  }

}