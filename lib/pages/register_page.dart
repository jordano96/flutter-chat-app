import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height*0.90,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(titulo: 'Registro',),
                _Form(),
                Labels(
                  ruta: 'login',
                  titulo: 'Ya tienes una cuenta',
                  subtitulo: 'Ingresa ahora!',
                  ),
                Text('Terminos y condiciones de uso',style: TextStyle(fontWeight: FontWeight.w200),)
              ],
        ),
            ),
          ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl=TextEditingController();
  final surnameCtrl=TextEditingController();
  final tlfCtrl=TextEditingController();
  final emailCtrl=TextEditingController();
  final passCtrl=TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.person,
            placeholder: 'Apellido',
            keyboardType: TextInputType.text,
            textController: surnameCtrl,
          ),
          CustomInput(
            icon: Icons.phone,
            placeholder: 'Telefono',
            keyboardType: TextInputType.number,
            textController: tlfCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contrasena',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Crear cuenta',
            onPressed: authService.autenticando ? null : () async {
               //print( nameCtrl.text );
               //print( surnameCtrl.text );
               //print( tlfCtrl.text );
               //print( emailCtrl.text );
               //print( passCtrl.text );

               final registroOk = await authService.register(nameCtrl.text.trim(),surnameCtrl.text.trim(),tlfCtrl.text.trim(),emailCtrl.text.trim(), passCtrl.text.trim());
               

               if ( registroOk == true ) {
                
                Navigator.pushReplacementNamed(context, 'usuarios');
               } else {
                 mostrarAlerta(context, 'Registro incorrecto', registroOk );
               }

             },
            )
        ],

      ),
      
    );
  }
}