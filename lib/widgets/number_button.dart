import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget{

  NumberButton({this.text,this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(56.0,56.0)),
        onPressed:onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        fillColor: Color.fromRGBO(255,50,85,0.5),
      )
    );
  }
}