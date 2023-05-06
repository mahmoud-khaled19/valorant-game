import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/view/screens/home/tasks_details_screen/switch_button.dart';
import 'package:workers/view_model/main_app_cubit/main_app_cubit.dart';
import 'package:workers/view_model/main_app_cubit/main_app_state.dart';

import '../../../../app_constance/assets_manager.dart';
import '../../../../app_constance/strings_manager.dart';
import '../../../../app_constance/values_manager.dart';
import '../../../widgets/default_custom_text.dart';

class TaskData extends StatelessWidget {
  const TaskData({Key? key, this.uploadedBy, this.taskId}) : super(key: key);
  final String? uploadedBy;
  final String? taskId;

  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.of(context).size.height;
    double wSize = MediaQuery.of(context).size.width;
    var user = FirebaseAuth.instance.currentUser!.uid;
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        MainAppCubit cubit = BlocProvider.of(context);
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10)),
          width: wSize * 0.9,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const DefaultCustomText(text: AppStrings.uploadedBy),
                  const SizedBox(
                    width: 40,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 30,
                        child: CircleAvatar(
                          radius: 27,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                  cubit.image ?? ImagesManager.loginImage,
                                ))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        DefaultCustomText(
                          text: cubit.name ?? AppStrings.tasks,
                        ),
                        SizedBox(
                          height: hSize * 0.005,
                        ),
                        DefaultCustomText(
                            text: cubit.position ?? AppStrings.tasks,
                            fontSize: 12,
                            color: Colors.grey.shade200),
                      ],
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultCustomText(
                      alignment: Alignment.centerLeft,
                      text: 'Uploaded on',
                      style: Theme.of(context).textTheme.titleMedium),
                  DefaultCustomText(
                    alignment: Alignment.centerRight,
                    text: cubit.uploadedOn.toString(),
                  ),
                ],
              ),
              SizedBox(
                height: hSize * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultCustomText(
                      alignment: Alignment.centerLeft,
                      text: 'Dead Line Date',
                      style: Theme.of(context).textTheme.titleMedium),
                  DefaultCustomText(
                    alignment: Alignment.centerRight,
                    text: cubit.deadLineDate ?? '',
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s16,
              ),
              DefaultCustomText(
                text: cubit.isDeadLineFinished!
                    ? 'Still Have Time'
                    : 'Finished Task Time',
                color: Colors.green,
              ),
              const Divider(
                thickness: 2,
              ),
              DefaultCustomText(
                  alignment: Alignment.centerLeft,
                  text: 'Done State :',
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: hSize * 0.01,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        if (uploadedBy == user) {
                          cubit.changeToDoneState(taskId, uploadedBy, context);
                        } else {
                          return;
                        }
                      },
                      child: const Text('Done')),
                  if (cubit.isDone == true)
                    Icon(
                      Icons.check_box,
                      color: Theme.of(context).splashColor,
                    ),
                  const SizedBox(
                    width: AppSize.s100,
                  ),
                  TextButton(
                      onPressed: () {
                        if (uploadedBy == user) {
                          cubit.changeToNotDoneState(
                              taskId, uploadedBy, context);
                        } else {
                          return;
                        }
                      },
                      child: const Text('Not Done')),
                  if (cubit.isDone == false)
                    Icon(
                      Icons.check_box,
                      color: Theme.of(context).splashColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              DefaultCustomText(
                  alignment: Alignment.centerLeft,
                  text: 'Task description',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: AppSize.s10,
              ),
              DefaultCustomText(
                alignment: Alignment.centerLeft,
                text: cubit.taskDescription ?? AppStrings.tasks,
              ),
              const SizedBox(
                height: AppSize.s16,
              ),
              AddCommentButton(
                taskId: taskId,
                uploadedBy: uploadedBy,
              )
            ],
          ),
        );
      },
    );
  }
}
