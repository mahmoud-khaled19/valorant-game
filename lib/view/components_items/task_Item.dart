import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workers/view/screens/home/tasks_details_screen/tasks_details_screen.dart';

import '../../app_constance/global_methods.dart';
import '../../app_constance/strings_manager.dart';

class TaskItem extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String taskId;
  final String uploadedBy;
  final bool isDone;

  const TaskItem({
    Key? key,
    required this.taskDescription,
    required this.taskTitle,
    required this.taskId,
    required this.isDone,
    required this.uploadedBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;
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
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: isDone
                ? const Icon(
                    Icons.alarm,
                    size: 30,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.green,
                  ),
          ),
        ),
        onTap: () {
          GlobalMethods.navigateTo(context,  TasksDetailsScreen(
            taskId: taskId,
            uploadedBy: uploadedBy,
          ));
        },
        onLongPress: () {
          if (user == uploadedBy) {
            showOnLongPressedFunction(context);
          } else {
            return;
          }
        },
        title: Text(
          taskTitle,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.linear_scale),
            Text(
              taskDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
        trailing: GestureDetector(
          onTap: () {},
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
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(taskId)
                        .delete();
                    Navigator.pop(context);
                  },
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
