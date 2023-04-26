import 'package:flutter/material.dart';

class GlobalMethods{

  static navigateTo(context,Widget widget){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  widget));
  }
}