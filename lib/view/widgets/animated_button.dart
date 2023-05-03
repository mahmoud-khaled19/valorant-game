import 'package:flutter/material.dart';
import 'package:workers/view/widgets/text_form_field_widget.dart';

import '../../app_constance/strings_manager.dart';
import 'default_button_widget.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({Key? key}) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    bool isCommenting = false;
    final TextEditingController commentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return  Form(
      key: formKey,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds:500 ),
        child: isCommenting == false
            ? DefaultButton(
          width: 160,
          text: 'Add Comment',
          function: () {
            setState(() {
              isCommenting = !isCommenting;
            });
          },
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
    );
  }
}
