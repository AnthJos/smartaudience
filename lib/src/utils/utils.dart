import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

bool isNumeric( String s ){

  if ( s.isEmpty ) return false;

  final n = num.tryParse(s);
  return ( n == null ) ? false : true;

}

void mostrarAlerta( BuildContext context, String mensaje ){

  showDialog(
    context: context,
    builder: ( context ){
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );

}

void mostrarVideo( BuildContext context, String link ){

  showDialog(
    context: context,
    builder: ( context ){
      return AlertDialog(
        backgroundColor: Colors.black,
        contentPadding: EdgeInsets.all(5.0),
        content: Container(
          width: double.infinity,
          height: 200.0,
          child: YoutubePlayer(
              context: context,
              source: link,
              quality: YoutubeQuality.HD,
          ),
        ),
      );
    }
  );

}

void mostrarConectado( BuildContext context ){

    showDialog(
      context: context,
      builder: ( context ){
        return AlertDialog(
          content: Container(
            height: 100.0,
            child: Center(
              child: CircularProgressIndicator(),
            )
          ),
        );
      }
    );

  }
void mostrarSalida( BuildContext context ){

    showDialog(
      context: context,
      builder: ( context ){
        return AlertDialog(
          content: Container(
            height: 100.0,
            child: Center(
              child: Text('Salida registrada, gracias por su participación.'),
            )
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
            )
          ],
        );
      }
    );

  }