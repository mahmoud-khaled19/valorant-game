import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/values_manager.dart';
import 'package:workers/view/screens/home/tasks_details_screen/comments_list.dart';
import 'package:workers/view/screens/home/tasks_details_screen/task_data.dart';
import 'package:workers/view_model/main_app_cubit/main_app_cubit.dart';
import 'package:workers/view_model/main_app_cubit/main_app_state.dart';
import '../../../../app_constance/strings_manager.dart';
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
    return BlocProvider(
      create: (context) => MainAppCubit()..getTasksData(context, taskId: taskId, upLoadedBy: uploadedBy),
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineLarge),
                  const SizedBox(height: AppSize.s14),
                  TaskData(
                    taskId: taskId,
                    uploadedBy: uploadedBy,
                  ),
                  const SizedBox(height: AppSize.s14),
                  CommentsList(
                    taskId: taskId,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
