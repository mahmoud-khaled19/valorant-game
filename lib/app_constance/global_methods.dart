import 'package:flutter/material.dart';
import 'package:workers/app_constance/strings_manager.dart';

import '../view/widgets/default_custom_text.dart';

class GlobalMethods {
  static navigateTo(context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static navigateAndFinish(context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  static showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      content: Text(text),
    ));
  }

  static final List<String> tasksSort = [
    'Programming',
    'Feasibility Study',
    'Accounting',
    'Marketing',
    'Designing',
    'Human Resources',
    'IT',
  ];
}
