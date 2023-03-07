import 'package:flutter/material.dart';

extension BottomSheetExtension on BuildContext {
  void showBottomSheetWidget({
    required Widget child,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Color? backgroundColor,
  }) {
    showModalBottomSheet(
      context: this,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      builder: (ctx) {
        return child;
      },
    );
  }
}
