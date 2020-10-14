import 'package:flutter/material.dart';


class BotonAzul extends StatelessWidget {
  final String text;
 final Function onPressed;
 final double heigthsize;

  const BotonAzul({Key key,@required this.text,@required this.onPressed,@required this.heigthsize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
            elevation: 2,
            highlightElevation: 5,
            color: Colors.blue,
            shape: StadiumBorder(),
            child: Container(
              width: double.infinity,
              height: heigthsize,
              child: Center(
                child: Text(this.text,style: TextStyle(color: Colors.white,fontSize: 17),),
              ),
            ),
            onPressed: this.onPressed
            );
  }
}