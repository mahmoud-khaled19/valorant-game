import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/app_constance/strings_manager.dart';
import 'package:workers/generated/assets.dart';
import 'package:workers/view/screens/home/home_screen/home_screen.dart';
import 'package:workers/view/screens/login_error_screen.dart';
import 'package:workers/view/widgets/default_button_widget.dart';
import 'package:workers/view/widgets/default_custom_text.dart';

import '../../../../view_model/auth_cubit/auth_cubit.dart';
import '../../../../view_model/auth_cubit/auth_state.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    Key? key,
    this.email,
    this.name,
    this.image,
    this.phone,
    this.position,
    this.userId,
    this.isSameUser,
  }) : super(key: key);
  final String? name;
  final String? phone;
  final String? email;
  final String? position;
  final String? image;
  final String? userId;
  final bool? isSameUser;

  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.of(context).size.height;
    double wSize = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => AuthCubit()..getUserData(context),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          AuthCubit cubit = BlocProvider.of(context);
          if (state is GetUserDataSuccessState) {
            return Scaffold(
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 30),
                          child: GestureDetector(
                            onTap: () {
                              GlobalMethods.navigateTo(
                                  context,  HomeScreen());
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
                        SizedBox(
                          height: hSize * 0.1,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: hSize * 0.56,
                          width: wSize * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).canvasColor),
                          child: Column(
                            children: [
                              SizedBox(
                                height: hSize * 0.12,
                              ),
                              DefaultCustomText(
                                text: name ?? cubit.name!,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DefaultCustomText(
                                text: position ?? cubit.position!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Theme.of(context).splashColor,
                                    ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              DefaultCustomText(
                                  alignment: Alignment.centerLeft,
                                  text: AppStrings.contactInfo,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(
                                height: 5,
                              ),
                              socialInfo(context, AppStrings.labelEmail,
                                  email ?? cubit.email),
                              socialInfo(context, AppStrings.labelPhone,
                                  phone ?? cubit.phone),
                              const SizedBox(
                                height: 20,
                              ),
                              if (userId != cubit.id! && isSameUser != true)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    socialButton(
                                      function: () {
                                        openWhatsApp(phone ?? cubit.phone!);
                                      },
                                      context: context,
                                      color: Colors.green,
                                      icon: Icons.chat,
                                      iconColor: Colors.green,
                                    ),
                                    socialButton(
                                      function: () {
                                        mailTo(email ?? cubit.email!);
                                      },
                                      context: context,
                                      color: Colors.red,
                                      icon: Icons.mail,
                                      iconColor: Colors.red,
                                    ),
                                    socialButton(
                                      function: () {
                                        callPhoneNumber(phone ?? cubit.phone!);
                                      },
                                      context: context,
                                      color: Colors.blue,
                                      icon: Icons.call,
                                      iconColor: Colors.blue,
                                    ),
                                  ],
                                ),
                              const Divider(
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DefaultButton(
                                width: wSize * 0.3,
                                text: AppStrings.logout,
                                function: () {
                                  cubit.signOutMethod(context);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: MediaQuery.of(context).size.width * 0.35,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                      image ?? cubit.imageUrl!,
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is GetUserDataLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const EmptyScreen(
              text: 'Error! Restart The App', image: Assets.imagesNoNews);
        },
      ),
    );
  }

  openWhatsApp(String phoneNumber) async {
    final Uri url = Uri.parse('https://wa.me/$phoneNumber');
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  mailTo(String mail) async {
    final Uri url = Uri.parse('mailto:$mail');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  callPhoneNumber(String phoneNumber) async {
    final Uri url = Uri.parse('tel:///$phoneNumber');
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  Widget socialButton({
    required context,
    required color,
    required function,
    required icon,
    required iconColor,
  }) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 26,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).canvasColor,
        radius: 24,
        child: IconButton(
          onPressed: function,
          icon: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget socialInfo(context, text, textButton) {
    return Row(
      children: [
        DefaultCustomText(
            alignment: Alignment.centerLeft,
            text: text,
            style: Theme.of(context).textTheme.titleLarge),
        TextButton(
            onPressed: () {},
            child: Text(
              textButton,
            ))
      ],
    );
  }
}
