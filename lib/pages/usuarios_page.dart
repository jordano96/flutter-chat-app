import 'package:chat/constant/constants.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';


class UsuariosPage extends StatefulWidget {

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  //String name;
  final usuariosService=new UsuariosService();

  RefreshController _refreshController =RefreshController(initialRefresh: false);
  List<Usuario>usuarios=[];
  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }
  
  /*Widget llamar(String phone){
    //String phone='0983970901';
    return Ink(
    height: 30,
    width: 30,
    decoration: const ShapeDecoration(
    color: Colors.lightGreen,
    shape: CircleBorder(),
    ),
    child: IconButton(
    iconSize: 15,             
    color: Colors.white,
    icon: Icon(Icons.call), 
    onPressed: ()async{   
    var url = 'tel:+593 $phone';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
    }, 
    ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>( context );
    final usuario=authService.usuario;
    
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue[400]),
        title: Center(
          child: Text(usuario.nombre+' '+usuario.apellido,style: TextStyle(color: Colors.black54),
          )),
        elevation: 1,
        /*leading: IconButton(
          icon: Icon(Icons.exit_to_app,color: Colors.black54,), 
          onPressed: (){

          }
          ),*/
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus==ServerStatus.Online)?Icon(Icons.check_circle,color: Colors.blue[400]):Icon(Icons.offline_bolt,color: Colors.red),
              //child: Icon(Icons.offline_bolt,color: Colors.red)
            )
          ],
        backgroundColor: Colors.white,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: _listViewUsuarios(),
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check,color: Colors.blue[400],),
          waterDropColor: Colors.blue[400],
        ),
        onRefresh: _cargarUsuarios,
        ),
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_,i)=>_usuarioListTile(usuarios[i]), 
      separatorBuilder: (_,i)=>Divider(), 
      itemCount: usuarios.length
      );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    String phone=usuario.telefono;
    //String name=usuario.nombre;
    return ListTile(
      onTap: ()async{   
    var url = 'tel:+593 $phone';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
    }, 
        title: Text(usuario.nombre),
        subtitle: usuario.online?Text('Conectado',style: TextStyle(color: Colors.green),):Text('Desconectado',style: TextStyle(color: Colors.red),),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: PopupMenuButton<String>(
                onSelected: (String choice){
                  
    if(choice == Constants.MapEspecifico){
      Navigator.pushNamed(context, 'mapsespecifico');
     
    }else if(choice == Constants.Ruta){
      Navigator.pushNamed(context, 'rutas');
      
    }else if(choice == Constants.Chat){
      //Navigator.pushNamed(context, 'maps');
      //Navigator.pushNamed(context, 'chat');
      //print(name);
      final chatService=Provider.of<ChatService>(context,listen: false);
      chatService.usuarioPara=usuario;
      Navigator.pushNamed(context, 'chat');
    }
  
                },
                itemBuilder: (BuildContext context){
                  return Constants.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ), /*Container(
          width: 80,
          //height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              llamar(usuario.telefono),
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context){
                  return Constants.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        )*/
      );
  }
  _cargarUsuarios()async{
    
    this.usuarios=await usuariosService.getUsuarios();
    setState(() {
      
    });

    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}