import 'dart:developer';

import 'package:flutter/material.dart';
import '../constants/typedefs.dart';
import '../widget/dialog.dart';

const Color _backgroundColor = Colors.transparent;

extension LoaderIndicatorExtension on BuildContext {
  Future<void> showLoader() async {
    Future.delayed(Duration.zero, () {
      log('In show loader');
      showDialog(
        barrierDismissible: false,
        context: this,
        barrierColor: _backgroundColor,
        useSafeArea: true,
        builder: (ctx) {
          return const Dialog.fullscreen(
            backgroundColor: _backgroundColor,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: _backgroundColor,
                color: Colors.blue,
              ),
            ),
          );
        },
      );
    });
  }

  Future showErrorLoader(RetryCallback retryCallback) {
    return showDialog(
      barrierDismissible: false,
      context: this,
      builder: (context) => CustomDialogBuilder(
        title: 'Something went wrong',
        message: 'Something happend while loading the data, please try again',
        actions: [
          DialogButtonData(
            onTap: () {
              Navigator.of(context).pop();
              retryCallback();
            },
            title: 'Ok',
          ),
        ],
      ),
    );
  }

  void hideLoader() {
    log('hideLoader');

    Navigator.of(this, rootNavigator: true).pop(true);
  }
}
