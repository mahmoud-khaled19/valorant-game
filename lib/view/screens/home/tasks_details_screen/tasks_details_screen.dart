import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/assets_manager.dart';
import 'package:workers/app_constance/values_manager.dart';
import 'package:workers/view/components_items/comments_item.dart';
import 'package:workers/view_model/main_app_cubit/main_app_cubit.dart';
import 'package:workers/view_model/main_app_cubit/main_app_state.dart';
import '../../../../app_constance/strings_manager.dart';
import '../../../widgets/animated_button.dart';
import '../../../widgets/default_custom_text.dart';

class TasksDetailsScreen extends StatelessWidget {
  const TasksDetailsScreen({
    Key? key,
    required this.uploadedBy,
    required this.taskId,
  }) : super(key: key);
  final String uploadedBy;
  final String taskId;

  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.of(context).size.height;
    double wSize = MediaQuery.of(context).size.width;
    var user = FirebaseAuth.instance.currentUser!.uid;
    return BlocProvider(
      create: (context) => MainAppCubit()
        ..getTasksData(context, taskId: taskId, upLoadedBy: uploadedBy),
      child: BlocBuilder<MainAppCubit, MainAppState>(
        builder: (context, state) {
          MainAppCubit cubit = BlocProvider.of(context);
          return state is GetTaskDataLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20, top: 60),
                            child: DefaultCustomText(
                              alignment: Alignment.centerLeft,
                              text: AppStrings.back,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.s16),
                        DefaultCustomText(
                            text: cubit.taskTitle ?? AppStrings.tasks,
                            style: Theme.of(context).textTheme.headlineLarge),
                        const SizedBox(height: AppSize.s14),
                        Container(
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
                                  DefaultCustomText(
                                      text: AppStrings.uploadedBy,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
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
                                                  cubit.image ??
                                                      ImagesManager.loginImage,
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
                                            text:
                                                cubit.name ?? AppStrings.tasks,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                        SizedBox(
                                          height: hSize * 0.005,
                                        ),
                                        DefaultCustomText(
                                            text: cubit.position ??
                                                AppStrings.tasks,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontSize: 12,
                                                    color:
                                                        Colors.grey.shade200)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultCustomText(
                                      alignment: Alignment.centerLeft,
                                      text: 'Uploaded on',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  DefaultCustomText(
                                      alignment: Alignment.centerRight,
                                      text: cubit.uploadedOn.toString() ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ],
                              ),
                              SizedBox(
                                height: hSize * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultCustomText(
                                      alignment: Alignment.centerLeft,
                                      text: 'Dead Line Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  DefaultCustomText(
                                      alignment: Alignment.centerRight,
                                      text: cubit.deadLineDate ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ],
                              ),
                              const SizedBox(
                                height: AppSize.s16,
                              ),
                              DefaultCustomText(
                                  text: cubit.isDeadLineFinished!
                                      ? 'Still Have Time'
                                      : 'Finished Task Time',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: Colors.green)),
                              const Divider(
                                thickness: 2,
                              ),
                              DefaultCustomText(
                                  alignment: Alignment.centerLeft,
                                  text: 'Done State :',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              SizedBox(
                                height: hSize * 0.01,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        if (uploadedBy == user) {
                                          cubit.changeToDoneState(
                                              taskId, uploadedBy, context);
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
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(
                                height: AppSize.s10,
                              ),
                              DefaultCustomText(
                                  alignment: Alignment.centerLeft,
                                  text:
                                      cubit.taskDescription ?? AppStrings.tasks,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              const SizedBox(
                                height: AppSize.s16,
                              ),
                              const AnimatedButton(),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSize.s14),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const CommentsList();
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 3,
                            );
                          },
                          itemCount: 20,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
