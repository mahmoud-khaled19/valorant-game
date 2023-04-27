import 'package:flutter/material.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/app_constance/strings_manager.dart';

import '../../../components/worker_item.dart';
import '../../../widgets/drawer_widget.dart';


class WorkersScreen extends StatelessWidget {
  const WorkersScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
          return const WorkerItem();
        },
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
