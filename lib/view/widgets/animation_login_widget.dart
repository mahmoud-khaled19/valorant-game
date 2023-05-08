import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:workers/generated/assets.dart';

import '../../app_constance/assets_manager.dart';

class LoginAnimationWidget extends StatefulWidget {
  const LoginAnimationWidget({Key? key}) : super(key: key);

  @override
  State<LoginAnimationWidget> createState() => _LoginAnimationWidget();
}

class _LoginAnimationWidget extends State<LoginAnimationWidget>
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
    return Image(
image:const  AssetImage(Assets.imagesLoginImage),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      alignment: FractionalOffset(animation.value, 0),
    );
  }
}
