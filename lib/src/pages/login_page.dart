import 'package:flutter/material.dart';

import 'package:smartaudience/src/bloc/provider.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';
import 'package:smartaudience/src/provider/usuario_provider.dart';
import 'package:smartaudience/src/utils/utils.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usuarioProvider = new UsuarioProvider();
  final _prefs = new PreferenciasUsuario();
  TextEditingController correo;
  TextEditingController password;

  bool passwordVisible = true;
  bool _bloquearCheck = false;

  @override
  void initState() {
    super.initState();
      correo = new TextEditingController( text: _prefs.correoUser );
      password = new TextEditingController( text: _prefs.passwordUser );

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context)
        ],
      ),
    );
  }

  Widget _loginForm( BuildContext context ){

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 160.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric( vertical: 20.0 ),
            padding: EdgeInsets.symmetric( vertical: 30.0 ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Login'),
                SizedBox( height: 10.0 ),
                _crearEmail( bloc ),
                SizedBox( height: 10.0 ),
                _crearPassword( bloc ),
                SizedBox( height: 10.0 ),
                _crearRecordar(),
                SizedBox( height: 10.0 ),
                _crearButton(bloc)
              ],
            ),
          ),
        ],
      ),
    );

  }

  Widget _crearEmail( LoginBloc bloc ){

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),
          child: TextField(
            controller: correo,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Color.fromRGBO(247, 146, 30, 1),),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              errorText: snapshot.error
            ),
            onChanged:bloc.changeEmail,
          ),
        );
      },
    );

  }

Widget _crearPassword( LoginBloc bloc ){

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),
          child: TextField(
            controller: password,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline , color: Color.fromRGBO(247, 146, 30, 1),),
              labelText: 'Contraseña',
              errorText: snapshot.error,
              suffixIcon: IconButton(
                icon: Icon(passwordVisible? Icons.visibility_off: Icons.visibility),
                color: Color.fromRGBO(247, 146, 30, 1),
                onPressed: (){
                  setState(() {
                      passwordVisible = !passwordVisible;
                  });
                },
              )
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );

  }

  Widget _crearRecordar(){

    return CheckboxListTile(
      activeColor: Color.fromRGBO(247, 146, 30, 1),
      title: Text('Recordar Contraseña', style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
      value: _bloquearCheck,
      onChanged: (value){
        setState(() {
         _bloquearCheck = value; 
        });
      },
    );

  }

  Widget _crearButton( LoginBloc bloc ){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          padding: EdgeInsets.symmetric( vertical: 15.0, horizontal: 80.0 ),
          child: Container(
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Color.fromRGBO(247, 146, 30, 1),
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      }
    );

  }

  _login( LoginBloc bloc, BuildContext context ) async {

    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if( info['ok'] ){
      if(_bloquearCheck){
        _prefs.correoUser = bloc.email;
        _prefs.passwordUser = bloc.password;
      }else{
        _prefs.correoUser = '';
        _prefs.passwordUser = '';
        bloc.changePassword("");
        bloc.changeEmail("");
      }
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      mostrarAlerta( context, info['mensaje'] );
    }

  }

  Widget _crearFondo( BuildContext context ){

    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(247, 146, 30, 1),
            Color.fromRGBO(247, 146, 30, 0.8)
          ]
        )
      ),
    );

    final circulo = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.1)
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned( top: 90.0, left: 30.0, child: circulo ),
        Positioned( top: -30.0, right: -50.0, child: circulo ),
        Positioned( bottom: -50.0, right: -30.0, child: circulo ),
        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 80.0,),
              SizedBox(height: 10.0, width: double.infinity,),
              Text('Smart Audience', style: TextStyle(color: Colors.white, fontSize: 25.0),)
            ],
          ),
        )
      ],
    );

  }
}