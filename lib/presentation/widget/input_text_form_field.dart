import 'package:flutter/material.dart';

import '../styles/fonts_theme.dart';
import 'custom_text_field.dart';

class InputTextFormFieldWidget extends StatelessWidget {
  const InputTextFormFieldWidget({
    Key? key,
    required this.labelText,
    required this.isRequired,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.maxLines,
  }) : super(key: key);
  final String labelText;
  final bool isRequired;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      textInputAction: textInputAction,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        label: Row(
          children: [
            Text(
              labelText,
              style: labelTextStyle(),
            ),
            if (isRequired)
              Text(
                '*',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
          ],
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
