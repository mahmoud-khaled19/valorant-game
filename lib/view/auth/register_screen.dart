import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/global_methods.dart';
import '../../app_constance/strings_manager.dart';
import '../../app_constance/values_manager.dart';
import '../../view_model/auth_cubit/auth_cubit.dart';
import '../../view_model/auth_cubit/auth_state.dart';
import '../../widgets/animation_login_widget.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/default_custom_text.dart';
import '../../widgets/text_form_field_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    FocusNode nameFocusNode = FocusNode();
    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();
    FocusNode phoneFocusNode = FocusNode();
    FocusNode positionFocusNode = FocusNode();
    double size = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          AuthCubit cubit = BlocProvider.of(context);
          return Scaffold(
            body: Stack(
              children: [
                const LoginAnimationWidget(),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.s20),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: size * 0.05,
                        ),
                        DefaultCustomText(
                          alignment: Alignment.centerLeft,
                          text: AppStrings.register,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        DefaultCustomText(
                          alignment: Alignment.centerLeft,
                          text: AppStrings.registerMessage,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        DefaultTextFormField(
                          onSubmittedFunction: () {
                            FocusScope.of(context).requestFocus(phoneFocusNode);
                          },
                          focusNode: nameFocusNode,
                          controller: nameController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return AppStrings.nameValidateMessage;
                            } else {
                              return null;
                            }
                          },
                          label: AppStrings.labelName,
                          prefixIcon: Icons.person,
                        ),
                        DefaultTextFormField(
                          onSubmittedFunction: () {
                            FocusScope.of(context)
                                .requestFocus(positionFocusNode);
                          },
                          focusNode: phoneFocusNode,
                          textType: TextInputType.phone,
                          controller: phoneController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return AppStrings.phoneValidateMessage;
                            } else {
                              return null;
                            }
                          },
                          label: AppStrings.labelPhone,
                          prefixIcon: Icons.phone,
                        ),
                        DefaultTextFormField(
                          onSubmittedFunction: () {
                            FocusScope.of(context).requestFocus(emailFocusNode);
                          },
                          focusNode: positionFocusNode,
                          controller: positionController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return AppStrings.positionValidateMessage;
                            } else {
                              return null;
                            }
                          },
                          label: AppStrings.labelPosition,
                          prefixIcon: Icons.work_history_outlined,
                        ),
                        DefaultTextFormField(
                          onSubmittedFunction: () {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                          focusNode: emailFocusNode,
                          controller: emailController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return AppStrings.emailValidateMessage;
                            } else {
                              return null;
                            }
                          },
                          label: AppStrings.labelEmail,
                          prefixIcon: Icons.email,
                        ),
                        DefaultTextFormField(
                          focusNode: passwordFocusNode,
                          textTypeAction: TextInputAction.done,
                          isSecure: cubit.isVisible,
                          controller: passwordController,
                          suffixIcon: cubit.isVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          suffixFunction: () {
                            cubit.changePasswordVisibility();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return AppStrings.passwordValidateMessage;
                            } else {
                              return null;
                            }
                          },
                          label: AppStrings.labelPassword,
                          prefixIcon: Icons.lock,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Visibility(
                          visible: state is! LoginInWithEmailLoadingState,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: DefaultButton(
                              text: AppStrings.login,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  emailController.clear();
                                  emailController.clear();
                                }
                              }),
                        ),
                        Row(
                          children: [
                            DefaultCustomText(
                                text: AppStrings.alreadyHaveAccount,
                                style: Theme.of(context).textTheme.titleSmall),
                            TextButton(
                                onPressed: () {
                                  GlobalMethods.navigateTo(
                                      context, const LoginScreen());
                                },
                                child: const Text(
                                  AppStrings.login,
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
