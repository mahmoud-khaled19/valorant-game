import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:workers/app_constance/global_methods.dart';

import 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  MainAppCubit() : super(MainAppInitial());

  MainAppCubit get(context) => BlocProvider.of(context);
  final FirebaseFirestore authStore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String? chosenCategory;
  bool isCommenting = false;

  changeAddCommentButton() {
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
      'isDone': false,
      'taskDescription': taskDescription,
      'taskCategory': taskCategory,
      'taskTitle': taskTitle,
      'taskComment': [],
    }).then((value) {
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

  changeCategoryFilter(context, index) {
    chosenCategory = GlobalMethods.tasksSort[index];
    Navigator.pop(context);
    emit(ChangeCategoryFilter());
  }

  cancelCategoryFilter(context) {
    Navigator.pop(context);
    chosenCategory = null;
    emit(ChangeCategoryFilter());
  }
}
