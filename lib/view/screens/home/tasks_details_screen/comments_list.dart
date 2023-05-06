import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/view/components_items/comments_item.dart';
import 'package:workers/view_model/main_app_cubit/main_app_cubit.dart';

import '../../../../view_model/main_app_cubit/main_app_state.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key, this.taskId}) : super(key: key);
final String? taskId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        MainAppCubit cubit =BlocProvider.of(context);
        return FutureBuilder<DocumentSnapshot>(
            future: cubit.authStore
                .collection('tasks')
                .doc(taskId)
                .get(),
            builder: (context, snapShots) {
              if (snapShots.hasData) {
                return ListView.separated(
                  reverse: true,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final commentData =
                    snapShots.data!['taskComment'][index];
                    return CommentItem(
                      userId: commentData['userId'],
                      commenterName:
                      commentData['commenterName'],
                      commentBody: commentData['commentBody'],
                      commenterImage: commentData['image'],
                      commentId: commentData['commentId'], // time: commentData['test'],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 3,
                    );
                  },
                  itemCount:
                  snapShots.data!['taskComment'].length,
                );
              }
              if (snapShots.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator());
              }
              return Container();
            });
      },
    );
  }
}
