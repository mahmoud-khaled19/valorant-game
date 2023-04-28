import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/global_methods.dart';
import '../../../app_constance/strings_manager.dart';
import '../../../app_constance/values_manager.dart';
import '../../../view_model/auth_cubit/auth_cubit.dart';
import '../../../view_model/auth_cubit/auth_state.dart';
import '../../widgets/animation_login_widget.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/default_custom_text.dart';
import '../../widgets/text_form_field_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

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
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: DefaultTextFormField(
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
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.12,
                                    width:
                                        MediaQuery.of(context).size.height *
                                            0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: cubit.imageFile == null
                                          ? CachedNetworkImage(
                                               imageUrl: 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',)
                                          : Image.file(
                                              cubit.imageFile!,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cubit.choosePhotoDialog(context);
                                      },
                                      icon: Icon(cubit.imageFile == null
                                          ? Icons.add_a_photo
                                          : Icons.edit))
                                ],
                              ),
                            )
                          ],
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
                          enabled: false,
                          function: () {
                            showPosition(context);
                          },
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
                            }
                            return null;
                          },
                          label: AppStrings.labelPassword,
                          onSubmittedFunction: (){
                            if (formKey.currentState!.validate()) {
                              GlobalMethods.navigateAndFinish(context, const LoginScreen());
                            }
                          },
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
                                  GlobalMethods.navigateAndFinish(context, const LoginScreen());
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

  void showPosition(context) {
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
                      positionController.text =
                          GlobalMethods.jopPositions[index];
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.check_box),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          GlobalMethods.jopPositions[index],
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
                ],
              )
            ],
          );
        });
  }

}
