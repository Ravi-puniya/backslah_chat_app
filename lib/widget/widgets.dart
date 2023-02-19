import 'package:flutter/material.dart';

final textinputdecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 1),
    ));

void nextscreen(context, page) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}

void showSnackbar(context,message,color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message,style: const TextStyle(fontSize: 14),),
    backgroundColor: color,
    duration: Duration(seconds: 2),
    action: SnackBarAction(onPressed:() {
      
    },label: "ok",textColor: Colors.white,),),
    
  );
}
