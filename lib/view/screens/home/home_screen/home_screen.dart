import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/strings_manager.dart';
import 'package:workers/view_model/main_app_cubit/main_app_cubit.dart';
import '../../../../generated/assets.dart';
import '../../../../view_model/main_app_cubit/main_app_state.dart';
import '../../../components_items/task_Item.dart';
import '../../../widgets/drawer_widget.dart';
import '../../login_error_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        MainAppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.showCategories(context);
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
                .collection('tasks')
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
                        text: 'No Tasks yet  ', image: Assets.imagesNoNews),
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
    );
  }
}
