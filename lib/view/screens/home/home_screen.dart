import 'package:flutter/material.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/app_constance/strings_manager.dart';
import '../../components/task_Item.dart';
import '../../widgets/default_custom_text.dart';
import '../../widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                GlobalMethods.showTasksCategoryMethod(context,widget: TextButton(
                  onPressed: () {},
                  child: DefaultCustomText(
                      text: AppStrings.cancelFilter,
                      style: Theme.of(context).textTheme.titleSmall),
                ));
              },
              icon: const Icon(Icons.sort_outlined))
        ],
        centerTitle: true,
        title: Text(
          AppStrings.tasks,
          style: TextStyle(color: Theme.of(context).splashColor),
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return const TaskItem();
        },
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

}
