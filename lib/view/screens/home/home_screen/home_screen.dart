import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/firebase_constance.dart';
import 'package:workers/app_constance/strings_manager.dart';
import 'package:workers/view_model/main_app_cubit/main_app_cubit.dart';
import '../../../../app_constance/global_methods.dart';
import '../../../../generated/assets.dart';
import '../../../../view_model/main_app_cubit/main_app_state.dart';
import '../../../components_items/task_Item.dart';
import '../../../widgets/default_custom_text.dart';
import '../drawer_screens/drawer_widget.dart';
import '../../login_error_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => MainAppCubit(),
  child: BlocConsumer<MainAppCubit, MainAppState>(
      listener: (context, state) {
        if (state is UploadTaskSuccessState) {
          GlobalMethods.showSnackBar(
              context, AppStrings.taskUploaded, Colors.green);
          GlobalMethods.navigateAndFinish(context, const HomeScreen());
        }
      },
      builder: (context, state) {
        MainAppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    GlobalMethods.showAlertDialog(
                      context: context,
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
                              onTap: () {
                                cubit.changeCategoryFilter(context, index);
                              },
                              child: Row(
                                children: [
                                  cubit.chosenCategory ==
                                          GlobalMethods.tasksSort[index]
                                      ? const Icon(Icons.check_box)
                                      : const Icon(
                                          Icons.check_box_outline_blank),
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
                          itemCount: GlobalMethods.tasksSort.length,
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
                                style: Theme.of(context).textTheme.titleSmall,
                                text: AppStrings.close,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                cubit.cancelCategoryFilter(context);
                              },
                              child: DefaultCustomText(
                                style: Theme.of(context).textTheme.titleSmall,
                                text: AppStrings.cancelFilter,
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  },
                  icon: const Icon(Icons.sort_outlined))
            ],
            centerTitle: true,
            title: Text(
              cubit.chosenCategory ?? AppStrings.tasks,
              style: TextStyle(color: Theme.of(context).splashColor),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(FirebaseConstance.taskCollection)
                .where('taskCategory', isEqualTo: cubit.chosenCategory)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapShot.connectionState == ConnectionState.active) {
                if (snapShot.data!.docs.isNotEmpty && snapShot.data != null) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = snapShot.data!.docs[index];
                      return TaskItem(
                        taskTitle: data['taskTitle'],
                        taskDescription: data['taskDescription'],
                        taskId: data['taskId'],
                        isDone: data['isDone'],
                        uploadedBy: data['uploadedBy'],
                      );
                    },
                    itemCount: snapShot.data!.docs.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      thickness: 3,
                    ),
                  );
                } else {
                  return const Center(
                    child: EmptyScreen(
                        text: AppStrings.noTasks, image: Assets.imagesNoNews),
                  );
                }
              }
              return const Center(
                child: EmptyScreen(
                    text: AppStrings.errorMessage, image: Assets.imagesNoNews),
              );
            },
          ),
        );
      },
    ),
);
  }
}
