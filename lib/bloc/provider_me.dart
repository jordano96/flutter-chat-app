import 'package:flutter/material.dart';
import 'package:chat/bloc/login_bloc.dart';
export 'package:chat/bloc/login_bloc.dart';

class ProviderMe extends InheritedWidget{


  static ProviderMe _instancia;

  factory ProviderMe({Key key, Widget child}){
    if(_instancia==null){
      _instancia=new ProviderMe._internal(key:key,child:child);

    }
    return _instancia;
  }

  ProviderMe._internal({Key key, Widget child})
       :super(key:key,child:child);

  final loginBloc=LoginBloc();

  

  @override
  bool updateShouldNotify(InheritedWidget oldWidget)=>true;

  static LoginBloc of (BuildContext context){
    return (context.inheritFromWidgetOfExactType(ProviderMe) as ProviderMe).loginBloc;
  }

}