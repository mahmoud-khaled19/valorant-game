import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/app_constance/strings_manager.dart';
import 'package:workers/generated/assets.dart';
import 'package:workers/view/screens/login_error_screen.dart';

import '../../../components_items//worker_item.dart';
import '../../../widgets/drawer_widget.dart';
import 'account_screen.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapShot.connectionState == ConnectionState.active) {
          if (snapShot.data!.docs.isNotEmpty) {
            return Scaffold(
              drawer:  DrawerWidget(),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  AppStrings.companyWorkers,
                  style: TextStyle(color: Theme.of(context).splashColor),
                ),
              ),
              body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = snapShot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      GlobalMethods.navigateTo(context,  AccountScreen(
                        image: data['image'],
                        phone: data['phone'],
                        name: data['name'],
                        position: data['position'],
                        userId: data['id'],
                        email: data['email'],
                        isSameUser: false,
                      ));
                    },
                    child: WorkerItem(
                      image: data['image'],
                      phone: data['phone'],
                      name: data['name'],
                      position: data['position'],
                      userId: data['id'],
                      email: data['email'],
                    ),
                  );
                },
                itemCount: snapShot.data!.docs.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 1,
                ),
              ),
            );
          } else {
            return const Center(
              child: EmptyScreen(
                  text: 'No Workers yet  ', image: Assets.imagesNoNews),
            );
          }
        }
        if (snapShot.hasError) {
          return const EmptyScreen(
              text: AppStrings.errorMessage, image: Assets.imagesNoNews);
        }
        return const Center(
          child: EmptyScreen(
              text: AppStrings.errorMessage, image: Assets.imagesNoNews),
        );
      },
    );
  }
}
