import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app_constance/assets_manager.dart';
import '../../app_constance/strings_manager.dart';
import '../../app_constance/values_manager.dart';
import '../../generated/assets.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/default_custom_text.dart';
import '../../widgets/default_list_tile.dart';
import '../../widgets/text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: ImagesManager.loginImage,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            alignment: FractionalOffset(animation.value, 0),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s20),
            child: ListView(
              children: [
                const SizedBox(
                  height: AppSize.s70,
                ),
                DefaultCustomText(
                  alignment: Alignment.centerLeft,
                  text: AppStrings.login,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                DefaultCustomText(
                  alignment: Alignment.centerLeft,
                  text: AppStrings.welcomeMessage,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                DefaultTextFormField(
                  controller: emailController,
                  validate: (String? value) {},
                  label: AppStrings.labelEmail,
                  prefixIcon: Icons.email,
                ),
                DefaultTextFormField(
                  controller: passwordController,
                  validate: (String? value) {},
                  label: AppStrings.labelPassword,
                  prefixIcon: Icons.lock,
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                DefaultCustomText(
                  alignment: Alignment.centerRight,
                  text: AppStrings.forgetPassword,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                DefaultButton(text: AppStrings.login, function: () {}),
                const SizedBox(
                  height: AppSize.s20,
                ),
                DefaultCustomText(
                  text: AppStrings.or,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                DefaultListTile(
                  text: AppStrings.signUpWithEmail,
                  function: () {},
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
          )
        ],
      ),
    );
  }
}
