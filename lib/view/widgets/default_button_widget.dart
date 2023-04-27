import 'package:flutter/material.dart';

import '../../app_constance/colors_manager.dart';
import '../../app_constance/values_manager.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final double radius;
  final double height;
  final double width;
  final Function() function;

  const DefaultButton({
    required this.text,
    this.height = AppSize.s50,
    this.width = double.infinity,
    this.radius = AppSize.s40,
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: ColorsManager.lightScaffoldColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ElevatedButton(
          onPressed: function,
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white))),
    );
  }
}
