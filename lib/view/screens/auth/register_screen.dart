import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/assets_manager.dart';
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
                          text: AppStrings.register.tr(),
                          style: Theme.of(context).textTheme.headlineLarge
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        DefaultCustomText(
                          alignment: Alignment.centerLeft,
                          text: AppStrings.registerMessage,
                          style: Theme.of(context).textTheme.titleMedium
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
                                label: AppStrings.labelName.tr(),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.height *
                                        0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: cubit.imageFile == null
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  ImagesManager.registerImage,
                                            )
                                          : Image.file(
                                              cubit.imageFile!,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        GlobalMethods.showAlertDialog(
                                          context: context,
                                          title: DefaultCustomText(
                                            text: AppStrings.options,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          content: const Divider(),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      cubit.pickImageWithCamera(
                                                          context);
                                                    },
                                                    child: Row(
                                                      children:  [
                                                        const Icon(Icons.camera),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(AppStrings.camera.tr())
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      cubit
                                                          .pickImageWithGallery(
                                                              context);
                                                    },
                                                    child: Row(
                                                      children:  [
                                                        const Icon(Icons
                                                            .picture_in_picture),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(AppStrings.gallery.tr())
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
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
                          label: AppStrings.labelPhone.tr(),
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
                              return AppStrings.emailValidateMessage.tr();
                            } else {
                              return null;
                            }
                          },
                          label: AppStrings.labelEmail.tr(),
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
                              return AppStrings.passwordValidateMessage.tr();
                            } else {}
                            return null;
                          },
                          label: AppStrings.labelPassword.tr(),
                          prefixIcon: Icons.lock,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Visibility(
                          visible: state is! RegisterWithEmailLoadingState,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: DefaultButton(
                              text: AppStrings.login.tr(),
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  if (cubit.imageFile != null) {
                                    cubit.registerWithEmailAndPassword(
                                      context: context,
                                      email: emailController.text
                                          .toLowerCase()
                                          .trim(),
                                      password: passwordController.text.trim(),
                                      phone: phoneController.text.trim(),
                                      name: nameController.text.trim(),
                                      position: positionController.text.trim(),
                                      time: Timestamp.now(),
                                      image: '${cubit.imageFile!}',
                                    );
                                  } else {
                                    GlobalMethods.showSnackBar(context,
                                        AppStrings.chooseImage, Colors.red);
                                  }
                                } else {
                                  return;
                                }
                              }),
                        ),
                        Row(
                          children: [
                            DefaultCustomText(
                              text: AppStrings.alreadyHaveAccount,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            TextButton(
                                onPressed: () {
                                  GlobalMethods.navigateTo(
                                      context, const LoginScreen());
                                },
                                child:  Text(
                                  AppStrings.login.tr(),
                                  style: const TextStyle(color: Colors.blue),
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
    GlobalMethods.showAlertDialog(
      context: context,
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
                positionController.text = GlobalMethods.jopPositions[index];
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
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        )
      ],
    );
  }
}
