import 'package:flutter/material.dart';

class DefaultCustomText extends StatelessWidget {
  final String text;
  final Alignment alignment;
  final TextStyle? style;

  const DefaultCustomText({
    super.key,
    required this.text,
    this.alignment = Alignment.center,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
