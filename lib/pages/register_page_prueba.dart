import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RegisterPagePrueba extends StatefulWidget {
 @override
 _RegisterPagePruebaState createState() => _RegisterPagePruebaState();
}

class _RegisterPagePruebaState extends State<RegisterPagePrueba> {
 GlobalKey<FormState> keyForm = new GlobalKey();
 TextEditingController  nameCtrl = new TextEditingController();
 TextEditingController  surnameCtrl = new TextEditingController();
 TextEditingController  emailCtrl = new TextEditingController();
 TextEditingController  mobileCtrl = new TextEditingController();
 TextEditingController  passwordCtrl = new TextEditingController();
 TextEditingController  repeatPassCtrl = new TextEditingController();

 @override
 Widget build(BuildContext context) {
   final socketService = Provider.of<SocketService>( context );
   
   return Scaffold(
     backgroundColor: Color(0xffF2F2F2),
       body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height*1,
          margin: EdgeInsets.only(top: 10,left: 30,right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Logo(titulo: 'Registro'),
              Form(
                key: keyForm,
                child: formUI(socketService),
              ),
              Labels(
                  ruta: 'login',
                  titulo: 'Ya tienes una cuenta',
                  subtitulo: 'Ingresa ahora!',
                  ),
                //Text('Terminos y condiciones de uso',style: TextStyle(fontWeight: FontWeight.w200),)
            ],
          ),
        ),
         ),
     );
   
 }

 formItemsDesign(icon, item) {
   return Padding(
     padding: EdgeInsets.symmetric(vertical: 2),
     child: Container(child: ListTile(leading: Icon(icon), title: item)),
   );
 }

 String gender = 'hombre';

 Widget formUI(dynamic socketService) {
   final authService = Provider.of<AuthService>( context );
   return  Column(
     children: <Widget>[
       formItemsDesign(
           Icons.person,
           TextFormField(
             controller: nameCtrl,
             decoration: new InputDecoration(
               labelText: 'Nombre',
             ),
             validator: validateName,
           )),
           formItemsDesign(
           Icons.person,
           TextFormField(
             controller: surnameCtrl,
             decoration: new InputDecoration(
               labelText: 'Apellido',
             ),
             validator: validateApellido,
           )),
       formItemsDesign(
           Icons.phone,
           TextFormField(
             controller: mobileCtrl,
               decoration: new InputDecoration(
                 labelText: 'Numero de telefono',
               ),
               keyboardType: TextInputType.phone,
               maxLength: 10,
               validator: validateMobile,)),
       formItemsDesign(
           Icons.email,
           TextFormField(
             controller: emailCtrl,
               decoration: new InputDecoration(
                 labelText: 'Email',
               ),
               keyboardType: TextInputType.emailAddress,
               maxLength: 32,
               validator: validateEmail,)),
       formItemsDesign(
           Icons.remove_red_eye,
           TextFormField(
             controller: passwordCtrl,
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Contraseña',
             ),
           )),
       formItemsDesign(
           Icons.remove_red_eye,
           TextFormField(
             controller: repeatPassCtrl,
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Repetir la Contraseña',
             ),
             validator: validatePassword,
           )),
           BotonAzul(
             heigthsize: 50,
            text: 'Crear cuenta',
            onPressed: authService.autenticando ? null : () async {
               //print( nameCtrl.text );
               //print( surnameCtrl.text );
               //print( tlfCtrl.text );
               //print( emailCtrl.text );
               //print( passCtrl.text );

               if (keyForm.currentState.validate()) {
                 //FocusScope.of(context).unfocus();
                 final registroOk = await authService.register(nameCtrl.text.trim(),surnameCtrl.text.trim(),mobileCtrl.text.trim(),emailCtrl.text.trim(), passwordCtrl.text.trim());
               

               if ( registroOk == true ) {
                 
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
               } else {
                 mostrarAlerta(context, 'Registro incorrecto', registroOk );
               }
                 
               }

             },
            )
   
     ],
   );
 }



 String validatePassword(String value) {
   print("valorrr $value passsword ${passwordCtrl.text}");
   if (value != passwordCtrl.text) {
     return "Las contraseñas no coinciden";
   }
   return null;
 }

 String validateName(String value) {
   String pattern = r'(^[a-zA-Z ]*$)';
   RegExp regExp = new RegExp(pattern);
   if (value.length == 0) {
     return "El nombre es necesario";
   } else if (!regExp.hasMatch(value)) {
     return "El nombre debe de ser a-z y A-Z";
   }
   return null;
 }

 String validateApellido(String value) {
   String pattern = r'(^[a-zA-Z ]*$)';
   RegExp regExp = new RegExp(pattern);
   if (value.length == 0) {
     return "El apellido es necesario";
   } else if (!regExp.hasMatch(value)) {
     return "El apellido debe de ser a-z y A-Z";
   }
   return null;
 }

 String validateMobile(String value) {
   String patttern = r'(^[0-9]*$)';
   RegExp regExp = new RegExp(patttern);
   if (value.length == 0) {
     return "El telefono es necesario";
   } else if (value.length != 10) {
     return "El numero debe tener 10 digitos";
   }
   return null;
 }

 String validateEmail(String value) {
   String pattern =
       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
   RegExp regExp = new RegExp(pattern);
   if (value.length == 0) {
     return "El correo es necesario";
   } else if (!regExp.hasMatch(value)) {
     return "Correo invalido";
   } else {
     return null;
   }
 }

 save() {
   if (keyForm.currentState.validate()) {
     /*print("Nombre ${nameCtrl.text}");
     print("Telefono ${mobileCtrl.text}");
     print("Correo ${emailCtrl.text}");
         keyForm.currentState.reset();*/
         
   }
 }
}