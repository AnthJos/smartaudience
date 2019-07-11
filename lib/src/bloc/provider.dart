import 'package:flutter/material.dart';

import 'package:smartaudience/src/bloc/conference_bloc.dart';
export 'package:smartaudience/src/bloc/conference_bloc.dart';

import 'package:smartaudience/src/bloc/login_bloc.dart';
export 'package:smartaudience/src/bloc/login_bloc.dart';

import 'package:smartaudience/src/bloc/career_bloc.dart';
export 'package:smartaudience/src/bloc/career_bloc.dart';

import 'package:smartaudience/src/bloc/user_bloc.dart';
export 'package:smartaudience/src/bloc/user_bloc.dart';

import 'package:smartaudience/src/bloc/workshop_bloc.dart';
export 'package:smartaudience/src/bloc/workshop_bloc.dart';

import 'package:smartaudience/src/bloc/document_bloc.dart';
export 'package:smartaudience/src/bloc/document_bloc.dart';


import 'package:smartaudience/src/bloc/question_bloc.dart';
export 'package:smartaudience/src/bloc/question_bloc.dart';

class Provider extends InheritedWidget {

  final loginBloc = LoginBloc();
  final _userBloc = UserBloc();
  final _careersBloc = CareerBloc();
  final _conferencesBloc = ConferenceBloc();
  final _workshopsBloc = WorkshopBloc();
  final _documentsBloc = DocumentBloc();
  final _questionsBloc = QuestionBloc();

  static Provider _instancia;

  factory Provider({ Key key, Widget child }){
    if( _instancia == null ){
      _instancia = new Provider._internal( key: key, child: child );
    }

    return _instancia;

  }

  Provider._internal({ Key key, Widget child })
    : super( key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider ).loginBloc;
  }

  static CareerBloc careersBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._careersBloc;
  }

  static UserBloc userBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._userBloc;
  }

  static ConferenceBloc conferencesBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._conferencesBloc;
  }

  static WorkshopBloc workshopsBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._workshopsBloc;
  }

  static DocumentBloc documentsBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._documentsBloc;
  }

  static QuestionBloc questionBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._questionsBloc;
  }

}