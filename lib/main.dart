import 'package:flutter/material.dart';

import 'package:workers_tasks/app_constance/strings_manager.dart';
import 'package:workers_tasks/app_constance/theme_manager.dart';
import 'package:workers_tasks/screens/login_screen.dart';

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
      theme: getLightApplicationTheme(),
      home: const LoginScreen(),
    );
  }
}
