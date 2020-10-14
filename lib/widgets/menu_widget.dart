import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
//import 'package:letsveganv1/providers/tema_bloc.dart';
//import 'package:provider/provider.dart';
class MenuWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    //final temabloc=Provider.of<ThemeNotifier>(context,listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu-img.jpg'),
                fit: BoxFit.cover
              )
            ) ,

            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.blue,),
              title: Text('Home'),
              onTap: ()=>Navigator.pushReplacementNamed(context, 'usuarios'),
            ),
            ListTile(
              leading: Icon(Icons.call,color: Colors.blue,),
              title: Text('Contactenos'),
              onTap: (){
                
              },
            ),
            /*SwitchListTile(
              title: Text('Dark Mode'),
              value: temabloc.isDarkMode, 
              onChanged: (val){
                 temabloc.toggleTheme();
              }
              ),*/
            ListTile(
              leading: Icon(Icons.settings,color: Colors.blue,),
              title: Text('Settings'),
              onTap: (){}
              ,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,color: Colors.blue,),
              title: Text('Cerrar sesion'),
              onTap: (){
                Navigator.pushReplacementNamed(context, 'login');

                AuthService.deleteToken();
                
                
              },
            ),
        ],
      ),

    );
  }
}