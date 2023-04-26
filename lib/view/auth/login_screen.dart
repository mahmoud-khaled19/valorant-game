import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/view/auth/register_screen.dart';
import '../../app_constance/strings_manager.dart';
import '../../app_constance/values_manager.dart';
import '../../generated/assets.dart';
import '../../view_model/auth_cubit/auth_cubit.dart';
import '../../view_model/auth_cubit/auth_state.dart';
import '../../widgets/animation_login_widget.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/default_custom_text.dart';
import '../../widgets/default_list_tile.dart';
import '../../widgets/text_form_field_widget.dart';
import '../screens/home_screen.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();
    var emailController = TextEditingController();
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
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(
                          height: AppSize.s70,
                        ),
                        DefaultCustomText(
                          alignment: Alignment.centerLeft,
                          text: AppStrings.login,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineLarge,
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        DefaultCustomText(
                          alignment: Alignment.centerLeft,
                          text: AppStrings.welcomeMessage,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        DefaultTextFormField(
                          onSubmittedFunction: () {
                            FocusScope.of(context).requestFocus(
                                passwordFocusNode);
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
                          textTypeAction: TextInputAction.done,
                          focusNode: passwordFocusNode,
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
                          height: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            GlobalMethods.navigateAndFinish(
                                context, const ForgotPasswordScreen());
                          },
                          child: DefaultCustomText(
                            alignment: Alignment.centerRight,
                            text: AppStrings.forgetPassword,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline
                            ),
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
                              text: AppStrings.login,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  GlobalMethods.navigateTo(
                                      context, const HomeScreen());
                                }
                              }),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        DefaultCustomText(
                          text: AppStrings.or,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        DefaultListTile(
                          text: AppStrings.signUpWithEmail,
                          function: () {
                            GlobalMethods.navigateAndFinish(
                                context, RegisterScreen());
                          },
                          image: Assets.imagesEmail,
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        DefaultListTile(
                            text: AppStrings.signUpWithGmail,
                            function: () {},
                            image: Assets.imagesGoogle),
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
