import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page_prueba.dart';
import 'package:chat/pages/maps_especifico.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/rutas.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes={
'usuarios':(_)=>UsuariosPage(),
'chat':(_)=>ChatPage(),
'login':(_)=>LoginPage(),
'register':(_)=>RegisterPage(),
'loading':(_)=>LoadingPage(),
'mapsespecifico':(_)=>MapsEspecificoPage(),
'rutas':(_)=>RutasPage(),
'prueba':(_)=>RegisterPagePrueba()
};