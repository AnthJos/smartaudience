import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:smartaudience/src/model/conference_model.dart';
import 'package:smartaudience/src/model/quest_model.dart';
import 'package:smartaudience/src/provider/quest_provider.dart';
import 'package:smartaudience/src/utils/utils.dart';

class DetalleConferencia extends StatefulWidget {

  const DetalleConferencia({Key key}) : super(key: key);

  @override
  _DetalleConferenciaState createState() => _DetalleConferenciaState();
}

class _DetalleConferenciaState extends State<DetalleConferencia> {

  ConferenceModel conference = new ConferenceModel();
  String pregunta;
  QuestModel preguntaModel = QuestModel();
  final enviarPregunta = QuestProvider();

  @override
  Widget build(BuildContext context) {


  final ConferenceModel prodData = ModalRoute.of(context).settings.arguments;
    if( prodData != null ){
      conference =  prodData;
    }


    return Scaffold(
      body: Column(
        children: <Widget>[
          _crearAppBar(conference)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.play_arrow,size: 35.0,),
            onPressed: () => mostrarVideo( context, conference.urlVideo ),
            backgroundColor: Color.fromRGBO(247, 146, 30, 1),
            ),
        ),
      ),
      bottomSheet: _crearDetalle(conference),
    );
  }

  Widget _crearAppBar( ConferenceModel conference ){

    final _screenSize = MediaQuery.of(context).size;
    final altura = _screenSize.height * 0.45;

    return Container(
      width: double.infinity,
      height: altura,
      color: Color.fromRGBO(239, 240, 241, 1),
      child: Stack(
        children: <Widget>[
          FadeInImage(
            width: double.infinity,
            image: NetworkImage(conference.urlImage),
            placeholder: AssetImage('assets/loading.gif'),
            fadeInDuration: Duration( microseconds: 150 ),
            fit: BoxFit.cover,
            height: altura,
          ),
          Container(
            width: double.infinity,
            height: altura,
            child: AppBar(
              title: Text(conference.title),
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
              elevation: 0.0,
            ),
          ),
        ],
      ),
    );

  }

  Widget _crearDetalle( ConferenceModel conference ){

    final _screenSize = MediaQuery.of(context).size;
    final altura = _screenSize.height * 0.55;

    return Container(
      width: double.infinity,
      height: altura,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 60.0,
            color: Color.fromRGBO(239, 240, 251, 1),
          ),
          Container(
            width: double.infinity,
            height: altura - 60.0,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Definicion', style: TextStyle(fontWeight: prefix0.FontWeight.bold, fontSize: 20.0),textAlign: TextAlign.left),
                SizedBox(height: 10.0,),
                Text(conference.description, style: TextStyle(fontSize: 16.0),),
                SizedBox(height: 10.0,),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 60.0),
                    child: Text('Preguntar'),
                    onPressed: (){

                      ingresarPregunta(context);

                    },
                    color: Color.fromRGBO(247, 146, 30, 1),
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

  }

  void ingresarPregunta( BuildContext context ){

    showDialog(
      context: context,
      builder: ( context ){
        return AlertDialog(
          title: Text('Ingresa la pregunta:'),
          content: Container(
            height: 100.0,
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.question_answer,color: Colors.orange,)
                ),
                onChanged: (value){
                  pregunta = value;
                },
              ),
            )
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Enviar'),
              onPressed: () async {
                preguntaModel.question = pregunta;
                preguntaModel.iduser = "user1";
                await enviarPregunta.registrarPreguntas(preguntaModel);
                Navigator.pushReplacementNamed(context, 'quest');
              },
              textColor: Colors.white,
              color: Colors.orange,
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: (){
                Navigator.pop(context);
              },
              textColor: Colors.white,
              color: Colors.orange,
            )
          ],
        );
      }
    );

  }

}