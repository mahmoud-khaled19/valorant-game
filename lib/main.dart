import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/view/screens/auth/user_login_states_screen.dart';
import 'package:workers/view_model/auth_cubit/auth_cubit.dart';
import 'package:workers/view_model/auth_cubit/auth_state.dart';
import 'package:workers/view_model/bloc%20observer.dart';
import 'app_constance/strings_manager.dart';
import 'app_constance/theme_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  runApp(EasyLocalization(
    useOnlyLangCode: true,
    saveLocale: true,
    supportedLocales: const [
      Locale(
        'en',
      ),
      Locale(
        'ar',
      ),
    ],
    fallbackLocale: const Locale('ar'),
    path: 'assets/translations',
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit()..getUserData(context),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            AuthCubit cubit = BlocProvider.of(context);
            return MaterialApp(
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              localeResolutionCallback: (deviceLocale, supportLocales) {
                for (var locale in supportLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }
                return null;
              },
              debugShowCheckedModeBanner: false,
              title: AppStrings.appTitle.tr(),
              theme: cubit.isDark
                  ? getDarkApplicationTheme()
                  : getLightApplicationTheme(),
              home: const UserLoginStates(),
            );
          },
        ));
  }
}
