import 'package:flutter/material.dart';
import 'package:workers/view/auth/login_screen.dart';

import 'app_constance/strings_manager.dart';
import 'app_constance/theme_manager.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getDarkApplicationTheme(),
      home:  const LoginScreen(),
    );
  }
}
