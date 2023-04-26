import 'package:flutter/material.dart';
import 'package:workers/app_constance/values_manager.dart';

import 'default_custom_text.dart';

class DefaultListTile extends StatelessWidget {
  const DefaultListTile(
      {Key? key,
      required this.text,
      required this.function,
      required this.image})
      : super(key: key);
  final String text;
  final String image;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: ListTile(
        title: DefaultCustomText(
            text: text,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14)),
        leading: Image(
          height: AppSize.s30,
          image: AssetImage(image),
        ),
        onTap: function,
      ),
    );
  }
}
