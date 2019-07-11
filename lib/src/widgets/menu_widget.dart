
import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

import 'package:smartaudience/src/bloc/provider.dart';
import 'package:smartaudience/src/provider/conference_provider.dart';
import 'package:smartaudience/src/provider/registro_provider.dart';



class MenuWidget extends StatefulWidget {
  
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

    final registroProvider = RegistroConferenceBeacon();
    final conferenceProvider = ConferenceProvider();
    int checkin;

  @override
  Widget build(BuildContext context) {

    final userBloc = Provider.userBloc(context);
      userBloc.cardaData();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _topData(userBloc, context),
          ListTile(
            leading: Icon(Icons.pages, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Carreras'),
            onTap: () => Navigator.pushNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(Icons.party_mode, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Mis Datos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'datos');
            },
          ),
          FutureBuilder(
            future: conferenceProvider.verificarConferencia(),
            builder: (BuildContext c, AsyncSnapshot<int> snapshot){
              final data = snapshot.data;
              if ( data != null && data > 0 ){
                return _checKin();
              }else{
                return Container();
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.file_download, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Documentos'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, 'documento');
              //Navigator.pushReplacementNamed(context, SettingsPage.routename);
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Preguntas'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, 'quest');
              //Navigator.pushReplacementNamed(context, SettingsPage.routename);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Escanear QR'),
            onTap: ()=> _scanQR(context),
          ),
          ListTile(
            leading: Icon(Icons.info, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Acerca de'),
            onTap: (){
              Navigator.pop(context);
              mostrarAcerca(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Cerrar Sesión'),
            onTap: (){
              imageCache.clear();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, 'sesionClose');
            },
          )
        ],
      ),
    );
  }

  Widget _checKin() {

    return FutureBuilder(
      future: registroProvider.verificarRegistroConferencia(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot){
        checkin = snapshot.data;
        if(checkin == 1){
          return ListTile(
            leading: Icon(Icons.radio_button_unchecked, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Check Out'),
            onTap: (){
              Navigator.pop(context);
              //Navigator.pushReplacementNamed(context, SettingsPage.routename);
            },
          );
        }else if(checkin == 0){
          return ListTile(
            leading: Icon(Icons.radio_button_checked, color: Color.fromRGBO(247, 146, 30, 1),),
            title: Text('Check In'),
            onTap: (){
              Navigator.pop(context);
              //Navigator.pushReplacementNamed(context, SettingsPage.routename);
            },
          );
        }else{
          return Container();
        }
      },
    );

  }

  Widget _topData( UserBloc userBloc, BuildContext context){

    return Container(
      color: Color.fromRGBO(247, 146, 30, 1),
      padding: EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0, bottom: 10.0),
      child: StreamBuilder(
          stream: userBloc.userStream,
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
            final data = snapshot.data;
            if( snapshot.hasData ){
              return Container(
                child: Column(
                  children: <Widget>[
                    _mostrarFoto(data),
                    SizedBox(height: 10.0,),
                    Text(data['name'], style: TextStyle(fontSize: 20.0, color: Colors.white),),
                    SizedBox(height: 10.0,),
                    Text(data['career'], style: TextStyle(fontSize: 14.0, color: Colors.white),)
                  ],
                ),
              );
            }else{
              return Container(
                height: 200.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
      ),
    );

  }

Widget _mostrarFoto( Map data ){

    if ( data['imagen'] != null ){
      return FadeInImage(
          image: NetworkImage(data['imagen']),
          placeholder: AssetImage('assets/no-image.png'),
          height: 200.0,
          fit: BoxFit.scaleDown,
        );
    }else{
      return Image(
        image: AssetImage('assets/no-image.png'),
        height: 200.0,
        fit: BoxFit.scaleDown,
      );
    }
}

  void mostrarAcerca( BuildContext context ){

    showDialog(
      context: context,
      builder: ( context ){
        return AlertDialog(
          title: Text('Acerca de', textAlign: TextAlign.center,),
          content: Image(
            image: AssetImage('assets/logo.png'),
            height: 150.0,
          )
        );
      }
    );

  }

  _scanQR(BuildContext context) async {

      String futureString = '';

      try {
        futureString = await QRCodeReader().scan();
      } catch(e) {
        futureString = e.toString();
      }

      if( futureString != null){

        /*final scan = ScanModel(valor: futureString);
        scanBloc.agregarScan(scan);

        if ( Platform.isIOS ) {
          Future.delayed(Duration(milliseconds: 750), (){
            utils.abrirScan(context, scan);
          });
        }else{
          utils.abrirScan(context, scan);
        }*/

        //print('--'+futureString);
        Navigator.pushNamed(context, 'verificarRegistro');
        
      }
    }
}