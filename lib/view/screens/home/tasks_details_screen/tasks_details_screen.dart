import 'package:flutter/material.dart';
import 'package:workers/app_constance/values_manager.dart';
import 'package:workers/view/components/comments_item.dart';
import 'package:workers/view/widgets/default_button_widget.dart';
import 'package:workers/view/widgets/text_form_field_widget.dart';

import '../../../../app_constance/global_methods.dart';
import '../../../../app_constance/strings_manager.dart';
import '../../../../generated/assets.dart';
import '../../../widgets/default_custom_text.dart';
import '../home_screen/home_screen.dart';

class TasksDetailsScreen extends StatefulWidget {
  const TasksDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TasksDetailsScreen> createState() => _TasksDetailsScreenState();
}

class _TasksDetailsScreenState extends State<TasksDetailsScreen> {
  final TextEditingController commentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isCommenting = false;

  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.of(context).size.height;
    double wSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 50),
              child: GestureDetector(
                onTap: () {
                  GlobalMethods.navigateTo(context, const HomeScreen());
                },
                child: const DefaultCustomText(
                  alignment: Alignment.centerLeft,
                  text: AppStrings.back,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s25,
            ),
            DefaultCustomText(
                text: AppStrings.tasks,
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(
              height: AppSize.s16,
            ),
            Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(10)),
                width: wSize * 0.9,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DefaultCustomText(
                            text: 'Uploaded By',
                            style: Theme.of(context).textTheme.titleSmall),
                        const Spacer(),
                        Positioned(
                          top: 100,
                          right: MediaQuery.of(context).size.width * 0.35,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    radius: 30,
                                    child: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage(Assets.imagesChild),
                                      radius: 27,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            DefaultCustomText(
                                text: 'Mahmoud Khaled',
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(
                              height: hSize * 0.005,
                            ),
                            DefaultCustomText(
                                text: 'Flutter Developer',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: Colors.grey.shade200)),
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultCustomText(
                            alignment: Alignment.centerLeft,
                            text: 'Uploaded on',
                            style: Theme.of(context).textTheme.titleMedium),
                        DefaultCustomText(
                            alignment: Alignment.centerRight,
                            text: '28-04-2023',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    SizedBox(
                      height: hSize * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultCustomText(
                            alignment: Alignment.centerLeft,
                            text: 'Dead Line Date',
                            style: Theme.of(context).textTheme.titleMedium),
                        DefaultCustomText(
                            alignment: Alignment.centerRight,
                            text: '30-04-2023',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                    SizedBox(
                      height: hSize * 0.007,
                    ),
                    DefaultCustomText(
                        text: 'Still Have Time',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.green)),
                    const Divider(
                      thickness: 2,
                    ),
                    DefaultCustomText(
                        alignment: Alignment.centerLeft,
                        text: 'Done State :',
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(
                      height: hSize * 0.01,
                    ),
                    Row(
                      children: [
                        DefaultCustomText(
                            text: 'Done ',
                            style: Theme.of(context).textTheme.titleSmall),
                        SizedBox(
                          width: wSize * 0.2,
                        ),
                        DefaultCustomText(
                            text: 'Not Done yet ',
                            style: Theme.of(context).textTheme.titleSmall),
                        Icon(
                          Icons.check_box,
                          color: Theme.of(context).splashColor,
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    DefaultCustomText(
                        alignment: Alignment.centerLeft,
                        text: 'Task description',
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(
                      height: hSize * 0.02,
                    ),
                    DefaultCustomText(
                        alignment: Alignment.centerLeft,
                        text: 'description ',
                        style: Theme.of(context).textTheme.titleSmall),
                    AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      child: isCommenting == false
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: wSize * 0.2,
                                vertical: hSize * 0.03,
                              ),
                              child: DefaultButton(
                                text: 'Add Comment',
                                function: () {
                                  setState(() {
                                    isCommenting = !isCommenting;
                                  });
                                },
                              ),
                            )
                          : Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: DefaultTextFormField(
                                    maxLines: 4,
                                    maxLength: 200,
                                    controller: commentController,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Insert your Comment';
                                      }
                                      return null;
                                    },
                                    label: 'Comment',
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
                                          function: () {
                                            if (formKey.currentState!
                                                .validate()) {
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
                                            setState(() {
                                              isCommenting = !isCommenting;
                                            });
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const CommentsList();
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
