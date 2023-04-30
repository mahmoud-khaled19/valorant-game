import 'package:flutter/material.dart';

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
      duration: const Duration(seconds: 5),
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
  static final List<String> jopPositions = [
    'Full Stack Developer',
    'Accountant',
    'Manager',
    'Designer',
    'Mobile Developer',
    'Digital Marketing',
    'Team Leader /Tester',
  ];
}
