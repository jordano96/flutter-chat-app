
import 'dart:async';

import 'package:chat/bloc/validators.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{
  //broadcast para que varias instancias pueda escuchar

  /*final _emailController=StreamController<String>.broadcast();
  final _passwordController=StreamController<String>.broadcast();*/

  final _emailController=BehaviorSubject<String>();
  final _passwordController=BehaviorSubject<String>();



  //Recuperar los datos del stream

  Stream<String> get emailStream=>_emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream=>_passwordController.stream.transform(validarPassword);
  Stream<bool> get formValidStream=>CombineLatestStream.combine2(emailStream,passwordStream,(e,p)=>true);
  

  //insert valores al stream

 Function(String) get changeEmail=>_emailController.sink.add;
 Function(String) get changePassword=>_passwordController.sink.add;

 //obtener los valores ultimos de mis stream
 String get email => _emailController.value;
 String get password=>_passwordController.value; 

 dispose(){
   _emailController?.close();
   _passwordController?.close();
 }


}