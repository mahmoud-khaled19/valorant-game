import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isCommenting=false;
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
                        chosenCategory == GlobalMethods.tasksSort[index]
                            ? const Icon(Icons.check_box)
                            : const Icon(Icons.check_box_outline_blank),
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
                    child:const DefaultCustomText(
                        text: AppStrings.close,),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      chosenCategory = null;
                      emit(ChangeCategoryFilter());
                    },
                    child:const DefaultCustomText(
                        text: AppStrings.cancelFilter,),
                  )
                ],
              )
            ],
          );
        });
  }
  changeAddCommentButton(){
    isCommenting = !isCommenting;
    emit(ChangeAddCommentState());
  }
  Future uploadTask({
    required String taskCategory,
    required String taskTitle,
    required String taskDescription,
    required Timestamp deadLineTimeStamp,
    required BuildContext context,
  }) async {
    var taskId = const Uuid().v4();
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
      GlobalMethods.showSnackBar(context, error.toString(), Colors.red);
      emit(UploadTaskSuccessState());
    });
  }

  String? taskDescription;
  String? taskCategory;
  String? taskTitle;
  List? taskComment;
  bool? isDone = false;
  bool? isDeadLineFinished = false;
  String? position;
  String? name;
  String? image;
  Timestamp? uploadedOnTimestamp;
  Timestamp? deadLineTimestamp;
  String? deadLineDate;
  String? uploadedOn;

  Future getTasksData(
    BuildContext context, {
    required String taskId,
    required String upLoadedBy,
  }) async {
    emit(GetTaskDataLoadingState());
    try {
      final DocumentSnapshot userDoc =
          await authStore.collection('users').doc(upLoadedBy).get();
      final DocumentSnapshot tasksDoc =
          await authStore.collection('tasks').doc(taskId).get();
      if (userDoc == null) {
        return;
      } else {
        ///users
        name = userDoc.get('name');
        image = userDoc.get('image');
        position = userDoc.get('position');

        /// tasks
        taskTitle = tasksDoc.get('taskTitle');
        taskDescription = tasksDoc.get('taskDescription');
        isDone = tasksDoc.get('isDone');
        taskCategory = tasksDoc.get('taskCategory');
        uploadedOnTimestamp = tasksDoc.get('uploadedOn');
        var postdate = uploadedOnTimestamp!.toDate();
        uploadedOn = '${postdate.year} / ${postdate.month} / ${postdate.day}';
        deadLineTimestamp = tasksDoc.get('DeadLineTime');
        var date = deadLineTimestamp!.toDate();
        deadLineDate = '${date.year} / ${date.month} / ${date.day}';
        isDeadLineFinished = date.isAfter(DateTime.now());
      }
      emit(GetTaskDataSuccessState());
    } catch (e) {
      print(e.toString());
      GlobalMethods.showSnackBar(context, e.toString(), Colors.red);
      emit(GetTaskDataErrorState());
    }
  }

  changeToDoneState(taskId, upLoadedBy, context) {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .update({'isDone': true});
    getTasksData(context, taskId: taskId, upLoadedBy: upLoadedBy);
  }

  changeToNotDoneState(taskId, upLoadedBy, context) {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .update({'isDone': false});
    getTasksData(context, taskId: taskId, upLoadedBy: upLoadedBy);
  }
}
