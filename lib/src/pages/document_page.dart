import 'package:flutter/material.dart';
import 'package:smartaudience/src/bloc/provider.dart';
import 'package:smartaudience/src/model/document_model.dart';

import 'package:url_launcher/url_launcher.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final documentsBloc = Provider.documentsBloc(context);
          documentsBloc.cargarDocuments();

    return Scaffold(
      appBar: AppBar(
        title: Text('Documentos'),
        backgroundColor: Color.fromRGBO(247, 146, 30, 1),
      ),
      body: StreamBuilder(
        stream: documentsBloc.documentStream,
        builder: (BuildContext context, AsyncSnapshot<List<DocumentModel>> snapshot){

          final documents = snapshot.data;
          print(documents);
          if( snapshot.hasData ){
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: ( context, i ) => _items( context, documentsBloc, documents[i] ),
            );
          }else{
            return Center(
                child: CircularProgressIndicator(),
            );
          }

        },
      ),
    );
  }

  Widget _items(BuildContext context, DocumentBloc documentsBloc, DocumentModel document){

    return ListTile(
      title: Text(document.title,),
      leading: Icon(Icons.file_download, color: Color.fromRGBO(247, 146, 30, 1),),
      subtitle: Text(document.tipo, style: TextStyle(fontSize: 12.0),),
      onTap: () async {
        if (await canLaunch(document.urlfile)) {
          await launch(document.urlfile);
        } else {
          throw 'Could not launch ${document.urlfile}';
        }
      },
    );

  }
}