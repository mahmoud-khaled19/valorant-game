import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/strings_manager.dart';
import 'package:workers/view/widgets/default_button_widget.dart';
import 'package:workers/view/widgets/default_custom_text.dart';
import 'package:workers/view_model/main_app_cubit/main_app_cubit.dart';
import '../../../../app_constance/global_methods.dart';
import '../../../../view_model/main_app_cubit/main_app_state.dart';
import '../../../widgets/text_form_field_widget.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController taskTitleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController deadLineDateController =
        TextEditingController();
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        MainAppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  DefaultCustomText(
                      text: AppStrings.allFieldsRequired,
                      style: Theme.of(context).textTheme.titleLarge),
                  const Divider(
                    thickness: 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTextFormField(
                    function: () {
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
                                        categoryController.text =
                                            GlobalMethods.tasksSort[index];
                                        Navigator.pop(context);
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
                                                ?.copyWith(
                                                    fontStyle:
                                                        FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: GlobalMethods.tasksSort.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
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
                                      child: const DefaultCustomText(
                                          text: AppStrings.close,)
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    enabled: false,
                    controller: categoryController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return categoryController.text = 'Choose Category';
                      }
                      return null;
                    },
                    label: 'Task Category',
                  ),
                  DefaultTextFormField(
                    maxLength: 30,
                    controller: taskTitleController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Task Title is Necessary';
                      }
                      return null;
                    },
                    label: AppStrings.taskTitle,
                  ),
                  DefaultTextFormField(
                    maxLines: 3,
                    maxLength: 1000,
                    controller: descriptionController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Task Title is Necessary';
                      }
                      return null;
                    },
                    label: 'Task Description',
                  ),
                  DefaultTextFormField(
                    enabled: false,
                    function: () async {
                      await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024))
                          .then((value) {
                        cubit.deadLineTimestamp =
                            Timestamp.fromMicrosecondsSinceEpoch(
                                value!.microsecondsSinceEpoch);
                        deadLineDateController.text =
                            '${value.year}/${value.month}/${value.day}';
                      });
                    },
                    controller: deadLineDateController,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Pick up dead Line Date';
                      }
                    },
                    textType: TextInputType.number,
                    label: 'Dead line Date',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: state is! UploadTaskLoadingState,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: DefaultButton(
                        text: AppStrings.upload,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit
                                .uploadTask(
                              taskCategory: categoryController.text,
                              taskTitle: taskTitleController.text,
                              taskDescription: descriptionController.text,
                              deadLineTimeStamp: cubit.deadLineTimestamp?? Timestamp.fromDate(DateTime.now()),
                              context: context,
                            )
                                .then((value) {
                              categoryController.clear();
                              taskTitleController.clear();
                              descriptionController.clear();
                              deadLineDateController.clear();
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(AppStrings.fillFields),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(AppStrings.close))
                                    ],
                                  );
                                });
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
