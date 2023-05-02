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
              drawer: const DrawerWidget(),
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
                  return GestureDetector(
                    onTap: () {
                      GlobalMethods.navigateTo(context,  AccountScreen(
                        image: snapShot.data!.docs[index]['image'],
                        phone: snapShot.data!.docs[index]['phone'],
                        name: snapShot.data!.docs[index]['name'],
                        position: snapShot.data!.docs[index]['position'],
                        userId: snapShot.data!.docs[index]['id'],
                        email: snapShot.data!.docs[index]['email'],
                      ));
                    },
                    child: WorkerItem(
                      image: snapShot.data!.docs[index]['image'],
                      phone: snapShot.data!.docs[index]['phone'],
                      name: snapShot.data!.docs[index]['name'],
                      position: snapShot.data!.docs[index]['position'],
                      userId: snapShot.data!.docs[index]['id'],
                      email: snapShot.data!.docs[index]['email'],
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
              text: 'Oops ! Error Happened ', image: Assets.imagesNoNews);
        }
        return const Center(
          child: EmptyScreen(
              text: 'Oops ! Error Happened ', image: Assets.imagesNoNews),
        );
      },
    );
  }
}
