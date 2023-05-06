import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:workers/view_model/main_app_cubit/main_app_cubit.dart';
import '../../../../app_constance/global_methods.dart';
import '../../../../app_constance/strings_manager.dart';
import '../../../../view_model/main_app_cubit/main_app_state.dart';
import '../../../widgets/default_button_widget.dart';

class AddCommentButton extends StatelessWidget {
  final String? taskId;
  final String? uploadedBy;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  AddCommentButton({Key? key, this.taskId, this.uploadedBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build button');
    var user = FirebaseAuth.instance.currentUser!.uid;

    return BlocBuilder<MainAppCubit, MainAppState>( 
      builder: (context, state) {
        MainAppCubit cubit = BlocProvider.of(context);
        return cubit.isCommenting == false
            ? DefaultButton(
                width: 160,
                text: 'Add Comment',
                function: () {
                  cubit.changeAddCommentButton();
                },
              )
            : Form(
                key: formKey,
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextFormField(
                        maxLines: 4,
                        maxLength: 200,
                        controller: commentController,
                        validator: (String? value) {
                          if (value!.isEmpty && value.length < 6) {
                            return AppStrings.passwordValidateMessage;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text('Comment'),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          DefaultButton(
                              text: 'Post',
                              fontSize: 14,
                              function: () async {
                                final commentId = const Uuid().v4();
                                if (formKey.currentState!.validate()) {
                                  final DocumentSnapshot userDoc = await cubit
                                      .authStore
                                      .collection('users')
                                      .doc(user)
                                      .get();
                                  await cubit.authStore
                                      .collection('tasks')
                                      .doc(taskId)
                                      .update({
                                    'taskComment': FieldValue.arrayUnion([
                                      {
                                        'image': userDoc.get('image'),
                                        'commentId': commentId,
                                        'userId': uploadedBy,
                                        'commentBody': commentController.text,
                                        'commentTime': Timestamp.now(),
                                        'commenterName': userDoc.get('name'),
                                      }
                                    ])
                                  }).then((value) {
                                    commentController.clear();
                                    GlobalMethods.showSnackBar(
                                        context,
                                        'Comment Added Successfully',
                                        Colors.green);
                                    FocusScope.of(context).unfocus();
                                  });
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultButton(
                              text: AppStrings.cancel,
                              fontSize: 14,
                              function: () {
                                cubit.changeAddCommentButton();
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
