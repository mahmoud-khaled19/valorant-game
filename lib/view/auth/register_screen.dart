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
import '../screens/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
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
                      children: [
                        const SizedBox(
                          height: AppSize.s50,
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
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        DefaultTextFormField(
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
                          height: AppSize.s30,
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
                                  GlobalMethods.navigateTo(
                                      context, const HomeScreen());
                                }
                              }),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Row(
                          children: [
                            DefaultCustomText(
                                text: AppStrings.alreadyHaveAccount,
                                style: Theme.of(context).textTheme.titleSmall),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  AppStrings.login,
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        )
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
