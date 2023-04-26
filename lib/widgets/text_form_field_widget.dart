import 'package:flutter/material.dart';

import '../app_constance/values_manager.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;

  final String? Function(String? val)? validate;
  final String label;
  final IconData? prefixIcon;

  final IconData? suffixIcon;
  final Function()? suffixFunction;
  final bool isSecure;
  final TextInputType textType;

  const DefaultTextFormField(
      {super.key,
      required this.controller,
      required this.validate,
      required this.label,
      required this.prefixIcon,
      this.suffixIcon,
      this.suffixFunction,
      this.isSecure = false,
      this.textType = TextInputType.emailAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          style: Theme.of(context).textTheme.titleMedium,
          obscureText: isSecure,
          keyboardType: textType,
          controller: controller,
          validator: validate,
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: Theme.of(context).splashColor,
            ),
            suffixIcon: GestureDetector(
                onTap: suffixFunction,
                child: Icon(
                  suffixIcon,
                  color: Theme.of(context).splashColor,
                )),
            labelText: label,
            labelStyle: Theme.of(context).textTheme.titleSmall,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: AppSize.s1),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).splashColor, width: AppSize.s1),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
          ),
        ),
      ],
    );
  }
}
