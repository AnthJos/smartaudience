import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:smartaudience/src/model/workshop_model.dart';
import 'package:smartaudience/src/model/workshop_registro_model.dart';
import 'package:smartaudience/src/provider/workshop_registro.dart';
import 'package:smartaudience/src/utils/utils.dart';

class DetalleTaller extends StatefulWidget {
  DetalleTaller({Key key}) : super(key: key);

  _DetalleTallerState createState() => _DetalleTallerState();
}

class _DetalleTallerState extends State<DetalleTaller> {

  int cantidadTaller;
  final cantidadregistro = new WorkshopRegistro();
  WorkshopModel workshop = new WorkshopModel();
  WorkshopRegisterModel workregistro = new WorkshopRegisterModel();

  @override
  Widget build(BuildContext context) {

    final WorkshopModel prodData = ModalRoute.of(context).settings.arguments;
    if( prodData != null ){
      workshop =  prodData;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _crearAppBar(workshop)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        height: 50.0,
        width: 50.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.play_arrow,size: 25.0,),
            onPressed: () => mostrarVideo( context, workshop.urlVideo ),
            backgroundColor: Color.fromRGBO(247, 146, 30, 1),
            ),
        ),
      ),
      bottomSheet: _crearDetalle(workshop),
    );
  }

  Widget _crearAppBar( WorkshopModel workshop ){

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
            image: NetworkImage(workshop.urlImage),
            placeholder: AssetImage('assets/loading.gif'),
            fadeInDuration: Duration( microseconds: 150 ),
            fit: BoxFit.cover,
            height: altura,
          ),
          Container(
            width: double.infinity,
            height: altura,
            child: AppBar(
              title: Text(workshop.title),
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: (){
                    Share.share('Participa del ${workshop.title} - ${workshop.theme}');
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );

  }

  Widget _crearDetalle( WorkshopModel workshop ){

    final _screenSize = MediaQuery.of(context).size;
    final altura = _screenSize.height * 0.55;

    return Container(
      width: double.infinity,
      height: altura,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 30.0,
            color: Color.fromRGBO(239, 240, 251, 1),
          ),
          Container(
            width: double.infinity,
            height: altura - 30.0,
            color: Color.fromRGBO(239, 240, 251, 1),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Definicion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),textAlign: TextAlign.left,),
                      SizedBox(height: 8.0,),
                      Text(workshop.description, style: TextStyle(fontSize: 14.0),),
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Horario', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),textAlign: TextAlign.left),
                      SizedBox(height: 8.0,),
                      Text('De: ${workshop.time}', style: TextStyle(fontSize: 14.0),),
                      SizedBox(height: 5.0,),
                      Text('De: ${workshop.timeFin}', style: TextStyle(fontSize: 14.0),),
                    ],
                  ),
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 60.0),
                    child: Text('Registrarse'),
                    onPressed: () async{
                      cantidadTaller = await cantidadregistro.obtener();
                      verificarCupos(context);
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

  void verificarCupos( BuildContext context ){

    int totalTaller = 30;
    int quedaTaller = totalTaller - cantidadTaller;

    if( quedaTaller == totalTaller){
      showDialog(
        context: context,
        builder: ( context ){
          return AlertDialog(
            title: Text('Atención'),
            content: Text('El taller esta lleno.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        }
      );
    }else{
      showDialog(
        context: context,
        builder: ( context ){
          return AlertDialog(
            title: Text('Atención'),
            content: Text('Hay $quedaTaller cupos disponibles en este taller, regístrese inmediatamente.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Aceptar'),
                onPressed: ()async{
                  workregistro.fechaini = DateTime.now().toString();
                  await cantidadregistro.registrarTaller(workregistro);
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'registradoPage');
                },
              ),
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        }
      );
    }

    

  }

}