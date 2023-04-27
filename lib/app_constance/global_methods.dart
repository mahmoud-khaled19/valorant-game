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
  static showTasksCategoryMethod(context,{required Widget widget}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                AppStrings.tasks,
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.check_box),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          GlobalMethods.tasksSort[index],
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  );
                },
                itemCount:  GlobalMethods.tasksSort.length,
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: DefaultCustomText(
                        text: AppStrings.close,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  widget
                ],
              )
            ],
          );
        });
  }

}
