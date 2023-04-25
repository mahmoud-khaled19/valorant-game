import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    backgroundColor: color,
    content: Text(text),
  ));
}
