import 'package:flutter/material.dart';
import 'package:workers/app_constance/strings_manager.dart';
import 'package:workers/view/widgets/default_button_widget.dart';
import 'package:workers/view/widgets/default_custom_text.dart';

import '../../../../app_constance/global_methods.dart';
import '../../../widgets/text_form_field_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController taskTitleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController deadLineDateController =
        TextEditingController();
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
                  GlobalMethods.showTasksCategoryMethod(context, widget: const Text(''),);
                  setState(() {
                    print('${categoryController.text} tt');
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
                maxLength: 100,
                controller: taskTitleController,
                validate: (String? value) {
                  return 'Task Title is Necessary';
                },
                label: 'Task Title',
              ),
              DefaultTextFormField(
                maxLines: 3,
                maxLength: 1000,
                controller: descriptionController,
                validate: (String? value) {
                  return 'Description is Necessary';
                },
                label: 'Task Description',
              ),
              DefaultTextFormField(
                enabled: false,
                function: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    deadLineDateController.text = value!.format(context);
                  });
                },
                controller: deadLineDateController,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    deadLineDateController.text =
                        TimeOfDay.now().format(context).toString();
                  }
                },
                textType: TextInputType.number,
                label: 'pick Up Date',
              ),
              const SizedBox(
                height: 20,
              ),
              DefaultButton(
                  text: 'Upload',
                  function: () {
                    if (formKey.currentState!.validate()) {
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Fill The Empty Fields'),
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}