import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/view/screens/home/home_screen/home_screen.dart';

import '../../app_constance/strings_manager.dart';
import '../../view/widgets/default_custom_text.dart';
import 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit() : super(MainAppInitial());

  MainAppCubit get(context) => BlocProvider.of(context);
  final FirebaseFirestore authStore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
 String? chosenCategory;
  showCategories(context) {
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
                    onTap: () {
                      chosenCategory = GlobalMethods.tasksSort[index];
                      Navigator.pop(context);
                      emit(ChangeCategoryFilter());
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
                        text: AppStrings.close,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      chosenCategory =null ;
                      emit(ChangeCategoryFilter());
                    },
                    child: DefaultCustomText(
                        text: AppStrings.cancelFilter,
                        style: Theme.of(context).textTheme.titleSmall),
                  )
                ],
              )
            ],
          );
        });
  }



  Future uploadTask({
    required String taskCategory,
    required String taskTitle,
    required String taskDescription,
    required String deadLineTimeStamp,
    required BuildContext context,
  }) async {
    var taskId =const Uuid().v4();
    emit(UploadTaskLoadingState());
    await authStore.collection('tasks').doc(taskId).set({
      'taskId': taskId,
      'uploadedBy': userId,
      'uploadedOn': Timestamp.now(),
      'DeadLineTime': deadLineTimeStamp,
      'position': 'position',
      'isDone': false,
      'taskDescription': taskDescription,
      'taskCategory': taskCategory,
      'taskTitle': taskTitle,
      'taskComment': [],
    }).then((value) {
      GlobalMethods.showSnackBar(
          context, 'Task Uploaded Successfully', Colors.green);
      GlobalMethods.navigateAndFinish(context, const HomeScreen());
      emit(UploadTaskSuccessState());
    }).catchError((error) {
      GlobalMethods.showSnackBar(
          context, error.toString(), Colors.red);
      emit(UploadTaskSuccessState());
    });
  }

  String? uploadedBy;
  String? uploadedOn;
  String? taskDescription;
  String? taskCategory;
  String? taskTitle;
  String? taskId;
  List? taskComment;
  bool? isDone;

  Future getTasksData(
      BuildContext context,
      ) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    print(userId);
    // emit(GetUserDataLoadingState());
    try {
      final DocumentSnapshot userDoc =
      await authStore.collection('users').doc(userId).get();
      if (userDoc == null) {
        print('UserDoc Is Null');
        return;
      } else {
        // email = userDoc.get('email');
        // name = userDoc.get('name');
        // phone = userDoc.get('phone');
        // imageUrl = userDoc.get('image');
        // position = userDoc.get('position');
        // id = userDoc.get('id');
        // Timestamp joinedAtStamp = userDoc.get('joined At');
        // var joinedDate = joinedAtStamp.toDate();
        // joinedAt = '${joinedDate.year}-${joinedDate.month}-${joinedDate.day}';
      }
      // emit(GetUserDataSuccessState());
    } catch (e) {
      print(e.toString());
      GlobalMethods.showSnackBar(context, e.toString(), Colors.red);
    }
  }
}
