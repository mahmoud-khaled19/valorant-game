import 'package:flutter/material.dart';
import 'default_custom_text.dart';

class DefaultListTile extends StatelessWidget {
  const DefaultListTile(
      {Key? key,
      required this.title,
      this.onLongPressed,
      this.subTitle,
      this.trailingWidget,
      required this.function,
      required this.leadingWidget})
      : super(key: key);
  final String title;
  final Widget? subTitle;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Function() function;
  final Function()? onLongPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        onLongPress: onLongPressed,
        title: DefaultCustomText(
            text: title,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14)),
        leading: leadingWidget,
        onTap: function,
        trailing: trailingWidget,
        subtitle: subTitle,
      ),
    );
  }
}
