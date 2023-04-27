import 'package:flutter/material.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/app_constance/strings_manager.dart';
import '../../../components/task_Item.dart';
import '../../../widgets/default_custom_text.dart';
import '../../../widgets/drawer_widget.dart';

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
                showCategories(context);
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
 showCategories(context){
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
                   onPressed: () {},
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
}
