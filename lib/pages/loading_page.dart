import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
//import 'package:loading/indicator/ball_pulse_indicator.dart';
//import 'package:loading/loading.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context,snapshot){
          return Container(
            child: Stack(
              alignment: Alignment.topCenter,
        children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/trackingcars.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              //heightFactor: 20,
              alignment: Alignment.bottomCenter,
              child: Text('Espere...',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
            Positioned(
              bottom: 48.0,
              left: 10.0,
              right: 10.0,
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Tracking Cars",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          "Es un sistema para el monitoreo de la unidades de la empresa TCPPLUMESAL S.A para saber en tiempo real la ubicacion de cada unidad de transporte"),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
          );
          /*return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Espere...',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                Loading(indicator: BallPulseIndicator(), size: 120.0, color: Colors.pink)
              ],
            ),
          );*/
        },     
      ),
   );
  }

  Future checkLoginState(BuildContext context)async{

    final authService=Provider.of<AuthService>(context,listen: false);
    final socketService = Provider.of<SocketService>( context,listen: false );
    final autenticado=await authService.isLoggedIn();
    if (autenticado) {
      socketService.connect();
      Navigator.pushReplacement(context, 
      PageRouteBuilder(
        pageBuilder: (_,__,___)=>UsuariosPage(),
        transitionDuration: Duration(milliseconds: 0)
        ));
    }else{
      Navigator.pushReplacement(context, 
      PageRouteBuilder(
        pageBuilder: (_,__,___)=>LoginPage(),
        transitionDuration: Duration(milliseconds: 0)
        ));

    }


  }
}