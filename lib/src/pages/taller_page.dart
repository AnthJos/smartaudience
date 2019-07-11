import 'package:flutter/material.dart';
import 'package:smartaudience/src/bloc/provider.dart';
import 'package:smartaudience/src/bloc/workshop_bloc.dart';
import 'package:smartaudience/src/model/workshop_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';

class TallerPage extends StatelessWidget {

  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    List<WorkshopModel> workshop = [];
    final workshopBloc = Provider.workshopsBloc(context);
          workshopBloc.cargarWorkshops();

    return Scaffold(
      body: StreamBuilder(
        stream: workshopBloc.workshopStream,
        initialData: workshop,
        builder: (BuildContext context, AsyncSnapshot<List<WorkshopModel>> snapshot){
          final workshops = snapshot.data;
          if( snapshot.hasData ){
            
            return ListView.builder(
              itemCount: workshops.length,
              itemBuilder: ( context, i ) => _items( context, workshopBloc, workshops[i] ),
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

  Widget _items(BuildContext context, WorkshopBloc workshopBloc, WorkshopModel workshop){

    final _screenSize = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Card(
          child: Row(
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(workshop.urlImage),
                placeholder: AssetImage('assets/jar-loading.gif'),
                width: _screenSize.width * 0.3,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              Container(
                width: _screenSize.width * 0.65,
                height: 100.0,
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(workshop.title),
                      subtitle: Text(workshop.theme),
                    ),
                    Text(workshop.time, textAlign: TextAlign.left,)
                  ],
                ),
              )
            ],
          ),
        ),
        FlatButton(
          child: Container(
            width: double.infinity,
            height: 100.0,
            margin: EdgeInsets.all(5.0),
          ),
          onPressed: () {
            _prefs.idTaller = workshop.id;
            Navigator.pushNamed(context, 'detalleTaller', arguments: workshop);
          },
        )
      ],
    );

  }
}