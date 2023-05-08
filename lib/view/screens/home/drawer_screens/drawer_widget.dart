import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/app_constance/assets_manager.dart';
import 'package:workers/app_constance/global_methods.dart';
import 'package:workers/app_constance/values_manager.dart';
import 'package:workers/view/screens/home/drawer_screens/add_task_screen.dart';
import 'package:workers/view/screens/home/drawer_screens/workers.dart';
import '../../../../app_constance/strings_manager.dart';
import '../../../../view_model/auth_cubit/auth_cubit.dart';
import '../../../../view_model/auth_cubit/auth_state.dart';
import 'account_screen.dart';
import '../../../widgets/default_custom_text.dart';
import '../../../widgets/default_list_tile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = BlocProvider.of(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).splashColor),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                              cubit.imageUrl ?? ImagesManager.loginImage,
                            ))),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    DefaultCustomText(
                        text: AppStrings.appTitle.tr(),
                        style: Theme.of(context).textTheme.titleMedium)
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              DefaultListTile(
                title: AppStrings.allTasks.tr(),
                function: () {
                  Navigator.pop(context);
                },
                leadingWidget: const Icon(Icons.task),
              ),
              DefaultListTile(
                title: AppStrings.account,
                function: () {
                  GlobalMethods.navigateTo(
                      context,
                      const AccountScreen(
                        isSameUser: true,
                      ));
                },
                leadingWidget: const Icon(Icons.account_circle_sharp),
              ),
              DefaultListTile(
                title: AppStrings.workers.tr(),
                function: () {
                  GlobalMethods.navigateTo(context, const WorkersScreen());
                },
                leadingWidget: const Icon(Icons.people),
              ),
              DefaultListTile(
                title: AppStrings.addTask,
                function: () {
                  GlobalMethods.navigateTo(context, AddTaskScreen());
                },
                leadingWidget: const Icon(Icons.add_task),
              ),
              DefaultListTile(
                title:
                    cubit.isDark ? AppStrings.lightMode : AppStrings.darkMode,
                function: () {
                  cubit.changeAppMode();
                },
                leadingWidget:
                    Icon(cubit.isDark ? Icons.brightness_4 : Icons.dark_mode),
              ),

              const Divider(
                thickness: 3,
              ),
              DefaultListTile(
                title: AppStrings.logout,
                function: () {
                  GlobalMethods.signOutMethod(
                      context, () => cubit.signOutMethod(context));
                },
                leadingWidget: const Icon(Icons.power_settings_new_outlined),
              ),
            ],
          ),
        );
      },
    );
  }
}
