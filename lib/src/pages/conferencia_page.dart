import 'package:flutter/material.dart';
import 'package:smartaudience/src/bloc/provider.dart';
import 'package:smartaudience/src/model/conference_model.dart';

class ConferenciaPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    List<ConferenceModel> conference = [];
    final conferencesBloc = Provider.conferencesBloc(context);
          conferencesBloc.cargarConferences();

    return Scaffold(
      body: StreamBuilder(
        stream: conferencesBloc.conferenceStream,
        initialData: conference,
        builder: (BuildContext context, AsyncSnapshot<List<ConferenceModel>> snapshot){
          final conferences = snapshot.data;
          print(conferences);
          if( snapshot.hasData ){
            return ListView.builder(
              itemCount: conferences.length,
              itemBuilder: ( context, i ) => _items( context, conferencesBloc, conferences[i] ),
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

  Widget _items(BuildContext context, ConferenceBloc conferencesBloc, ConferenceModel conference){

    final _screenSize = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Card(
          child: Row(
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(conference.urlImage),
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
                      title: Text(conference.title),
                      subtitle: Text(conference.theme),
                    ),
                    Text(conference.time, textAlign: TextAlign.left,)
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
          onPressed: () => Navigator.pushNamed(context, 'detalleConference', arguments: conference),
        )
      ],
    );

  }
}