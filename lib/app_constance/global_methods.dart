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
      duration: const Duration(seconds: 3),
      backgroundColor: color,
      content: Text(text),
    ));
  }

  static showAlertDialog({
    required BuildContext context,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColorDark,
            title: title,
            content: content,
            actions: actions,
          );
        });
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
  static signOutMethod(context,Function() function){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                AppStrings.signOut,
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Text(AppStrings.signOutMessage),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:  DefaultCustomText(text: AppStrings.cancel,
                    style: Theme.of(context).textTheme.titleMedium,),
                  ),
                  TextButton(
                    onPressed: function,
                    child:  DefaultCustomText(
                      text: AppStrings.ok,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
