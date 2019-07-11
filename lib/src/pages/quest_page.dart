import 'package:flutter/material.dart';
import 'package:smartaudience/src/bloc/provider.dart';
import 'package:smartaudience/src/model/quest_model.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _questionBloc = Provider.questionBloc(context);
          _questionBloc.cargarQuestion();

    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas'),
        backgroundColor: Color.fromRGBO(247, 146, 30, 1),
      ),
      body: StreamBuilder(
        stream: _questionBloc.questionStream,
        builder: (BuildContext context, AsyncSnapshot<List<QuestModel>> snapshot){

          final questions = snapshot.data;
          if( snapshot.hasData ){
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: ( context, i ) => _items( context, _questionBloc, questions[i] ),
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

  Widget _items(BuildContext context, QuestionBloc questionBloc, QuestModel quest){

    return ListTile(
      title: Text(quest.question,),
      leading: Icon(Icons.question_answer, color: Color.fromRGBO(247, 146, 30, 1),),
      subtitle: Text(quest.iduser, style: TextStyle(fontSize: 12.0),),
    );

  }
}