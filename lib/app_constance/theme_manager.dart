import 'package:flutter/material.dart';
import 'package:workers/app_constance/style_manager.dart';
import 'package:workers/app_constance/values_manager.dart';
import 'colors_manager.dart';

ThemeData getLightApplicationTheme() {
  return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
        ColorsManager.lightIconsColor,
      ))),
      appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(
              fontSize: AppSize.s18, fontWeight: FontWeight.bold),
          backgroundColor: ColorsManager.darkScaffoldColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorsManager.black)),
      drawerTheme:
          DrawerThemeData(backgroundColor: ColorsManager.lightScaffoldColor),
      colorScheme:
          ColorScheme.light(background: ColorsManager.lightBackgroundColor),
      iconTheme: IconThemeData(
          color: ColorsManager.lightIconsColor, size: AppSize.s25),
      scaffoldBackgroundColor: ColorsManager.lightScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.lightIconsColor,
      primaryColor: ColorsManager.lightCardColor,
      disabledColor: ColorsManager.grey,
      cardColor: ColorsManager.lightCardColor,
      textTheme: TextTheme(
          headlineLarge:
              getBoldStyle(fontSize: AppSize.s40, color: ColorsManager.black),
          titleLarge: getSemiBoldStyle(
              fontSize: AppSize.s18, color: ColorsManager.black),
          titleMedium:
              getMediumStyle(fontSize: AppSize.s16, color: ColorsManager.black),
          titleSmall: getRegularStyle(
              fontSize: AppSize.s14, color: ColorsManager.black)),
      brightness: Brightness.light);
}

ThemeData getDarkApplicationTheme() {
  return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
        ColorsManager.darkIconsColor,
      ))),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.darkScaffoldColor,
        elevation: 0,
        titleTextStyle:
            const TextStyle(fontSize: AppSize.s18, fontWeight: FontWeight.bold),
      ),
      drawerTheme:
          DrawerThemeData(backgroundColor: ColorsManager.darkScaffoldColor),
      colorScheme:
          ColorScheme.dark(background: ColorsManager.lightBackgroundColor),
      iconTheme:
          IconThemeData(color: ColorsManager.darkIconsColor, size: AppSize.s25),
      scaffoldBackgroundColor: ColorsManager.darkScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.darkIconsColor,
      primaryColor: ColorsManager.darkCardColor,
      disabledColor: ColorsManager.grey,
      cardColor: ColorsManager.darkCardColor,
      textTheme: TextTheme(
          headlineLarge: getBoldStyle(
              fontSize: AppSize.s40, color: ColorsManager.lightScaffoldColor),
          titleLarge: getSemiBoldStyle(
              fontSize: AppSize.s18, color: ColorsManager.lightScaffoldColor),
          titleMedium: getMediumStyle(
              fontSize: AppSize.s16, color: ColorsManager.lightScaffoldColor),
          titleSmall: getRegularStyle(
              fontSize: AppSize.s14, color: ColorsManager.lightScaffoldColor)),
      brightness: Brightness.dark);
}
