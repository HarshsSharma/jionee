// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'custom_text_field.dart';

typedef ValidatorCallback = String? Function(String? value)?;
typedef OnSavedCallback = void Function(String? value)?;

class InputTextFormFieldWidget extends StatelessWidget {
  const InputTextFormFieldWidget({
    Key? key,
    required this.labelText,
    required this.isRequired,
    this.controller,
    this.validator,
    this.onSaved,
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
  final ValidatorCallback validator;
  final OnSavedCallback onSaved;
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
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? Colors.grey[850]!
              : Colors.white,
      borderColor: Theme.of(context).colorScheme.brightness == Brightness.dark
          ? Colors.grey[700]!
          : AppColors.boGrey,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        label: Row(
          children: [
            Text(
              labelText,
              style: Theme.of(context).textTheme.titleMedium,
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
