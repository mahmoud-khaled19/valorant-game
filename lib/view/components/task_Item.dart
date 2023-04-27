import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_constance/strings_manager.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.only(right: 12, top: 20),
          decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.grey),
              )),
          child: const CircleAvatar(
            radius: 20,
            child: Icon(
              Icons.alarm,
              size: 40,
            ),
          ),
        ),
        onTap: () {},
        onLongPress: () {
          showOnLongPressedFunction(context);
        },
        title: Text(
          'Title' * 2,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.linear_scale),
            Text(
              'Sub Title' * 15,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
        trailing:  GestureDetector(
          onTap: (){},
          child: Icon(
            Icons.keyboard_arrow_right,
            color: Theme.of(context).splashColor,
          ),
        ),
      ),
    );
  }

  void showOnLongPressedFunction(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.delete,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.delete,
                        color: Theme.of(context).splashColor,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
