import 'package:flutter/material.dart';

class DialogButtonData {
  final String title;
  final VoidCallback onTap;
  const DialogButtonData({
    required this.title,
    required this.onTap,
  });
}

class CustomDialogBuilder extends StatelessWidget {
  const CustomDialogBuilder({
    Key? key,
    this.message,
    required this.title,
    this.content,
    this.actions,
  }) : super(key: key);
  final String? message;
  final String title;
  final Widget? content;
  final List<DialogButtonData>? actions;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : content,
      actions: actions
          ?.map(
            (data) => TextButton(
              onPressed: data.onTap,
              child: Text(
                data.title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          )
          .toList(),
    );
  }
}
