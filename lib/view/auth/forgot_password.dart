import 'package:flutter/material.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/app_constance/strings_manager.dart';
import 'package:workers/app_constance/values_manager.dart';
import 'package:workers/view/auth/login_screen.dart';
import 'package:workers/widgets/default_button_widget.dart';
import 'package:workers/widgets/default_custom_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DefaultCustomText(
                alignment: Alignment.centerLeft,
                text: AppStrings.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              DefaultCustomText(
                alignment: Alignment.centerLeft,
                text: AppStrings.forgetPasswordMessage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              TextFormField(
                controller: emailController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return AppStrings.emailValidateMessage;
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  label: const Text(
                    AppStrings.labelEmail,
                  ),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Theme.of(context).splashColor),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).splashColor,
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: AppSize.s1),
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).splashColor,
                        width: AppSize.s1),
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              DefaultButton(
                  text: AppStrings.resetPassword,
                  function: () {
                    if (formKey.currentState!.validate()) {
                      GlobalMethods.navigateAndFinish(
                          context, const LoginScreen());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
