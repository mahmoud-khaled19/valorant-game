import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/view/screens/auth/user_login_states_screen.dart';
import 'package:workers/view_model/auth_cubit/auth_cubit.dart';
import 'app_constance/strings_manager.dart';
import 'app_constance/theme_manager.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: getDarkApplicationTheme(),
        home: const UserLoginStates(),
      ),
    );
  }
}
