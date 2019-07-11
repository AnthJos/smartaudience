import 'package:flutter/material.dart';
import 'package:smartaudience/src/bloc/provider.dart';
import 'package:smartaudience/src/model/career_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';

class HomePage extends StatelessWidget {

  final _prefs = new PreferenciasUsuario();
        
  @override
  Widget build(BuildContext context) {

    final careersBloc =  Provider.careersBloc(context);
      careersBloc.cargarCareers();

    return Scaffold(
      body: _crearListado( careersBloc ),
    );
  }

  Widget _crearListado( CareerBloc careersBloc ){

    return StreamBuilder(
      stream: careersBloc.careersStream,
      builder: (BuildContext context, AsyncSnapshot<List<CareerModel>> snapshot){
        final careers = snapshot.data;

        if( snapshot.hasData ){
          return ListView.builder(
            itemCount: careers.length,
            itemBuilder: ( context, i ) => _crearItem( context, careersBloc, careers[i] ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    ); 

  }

  Widget _crearItem( BuildContext context, CareerBloc careersBloc, CareerModel career ){

    final _screenSize = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(0.0),
          child: FadeInImage(
            image: NetworkImage(career.imagen),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 220.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: _botonCareer(career, context),
            height: 180.0,
            width: _screenSize.width - 40.0,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.7),
              borderRadius: BorderRadius.circular(10.0)
            ),
          ),
        ),
      ],
    );

  }

  Widget _botonCareer( CareerModel career, BuildContext context ){

    return FlatButton(
      padding: EdgeInsets.all(20.0),
      onPressed: () {
        _prefs.idCareer = career.id;
        Navigator.pushNamed(context, 'menu');
      },
      color: Colors.transparent,
      child: Text(career.name, style: TextStyle(color: Colors.white, fontSize: 30.0), textAlign: TextAlign.center,),
    );

  }

}