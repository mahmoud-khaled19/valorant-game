import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/view/screens/auth/register_screen.dart';
import '../../../app_constance/strings_manager.dart';
import '../../../app_constance/values_manager.dart';
import '../../../generated/assets.dart';
import '../../../view_model/auth_cubit/auth_cubit.dart';
import '../../../view_model/auth_cubit/auth_state.dart';
import '../../widgets/animation_login_widget.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/default_custom_text.dart';
import '../../widgets/default_list_tile.dart';
import '../../widgets/localization.dart';
import '../../widgets/text_form_field_widget.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocBuilder<AuthCubit, AuthState>(
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
                      const SizedBox(
                        height: AppSize.s70,
                      ),
                      DefaultCustomText(
                          alignment: Alignment.centerLeft,
                          text: AppStrings.login.tr(),
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      DefaultCustomText(
                          alignment: Alignment.centerLeft,
                          text: AppStrings.welcomeMessage.tr(),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      DefaultTextFormField(
                        controller: emailController,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.emailValidateMessage.tr();
                          } else {
                            return null;
                          }
                        },
                        label: AppStrings.labelEmail.tr(),
                        prefixIcon: Icons.email,
                      ),
                      DefaultTextFormField(
                        onSubmittedFunction: () {
                          if (formKey.currentState!.validate()) {
                            cubit
                                .loginWithEmailAndPassword(
                              email: emailController.text.toLowerCase().trim(),
                              password: passwordController.text.trim(),
                              context: context,
                            )
                                .then((value) {
                              FocusScope.of(context).unfocus();
                            });
                          }
                        },
                        isSecure: cubit.isVisible,
                        controller: passwordController,
                        suffixIcon: cubit.isVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        suffixFunction: () {
                          cubit.changePasswordVisibility();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty && value.length < 6) {
                            return AppStrings.passwordValidateMessage.tr();
                          } else {
                            return null;
                          }
                        },
                        label: AppStrings.labelPassword.tr(),
                        prefixIcon: Icons.lock,
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      GestureDetector(
                        onTap: () {
                          GlobalMethods.navigateTo(
                              context, const ForgotPasswordScreen());
                        },
                        child: DefaultCustomText(
                          alignment: Alignment.centerRight,
                          text: AppStrings.forgetPassword,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline),
                        ),
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
                            text: AppStrings.login.tr(),
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit
                                    .loginWithEmailAndPassword(
                                  email:
                                      emailController.text.toLowerCase().trim(),
                                  password: passwordController.text.trim(),
                                  context: context,
                                )
                                    .then((value) {
                                  FocusScope.of(context).unfocus();
                                });
                              }
                            }),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      DefaultCustomText(
                        text: AppStrings.or.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      DefaultListTile(
                        title: AppStrings.signUpWithEmail.tr(),
                        function: () {
                          GlobalMethods.navigateAndFinish(
                              context, RegisterScreen());
                        },
                        leadingWidget: const Image(
                          height: AppSize.s30,
                          image: AssetImage(Assets.imagesEmail),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      const LocalizationTheme(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
