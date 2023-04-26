import 'package:flutter/material.dart';

class GlobalMethods{

  static navigateTo(context,Widget widget){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  widget));
  }
  static navigateAndFinish(context,Widget widget){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  widget));
  }
}