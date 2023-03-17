import 'package:flutter/material.dart';

import '../styles/colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
    this.color = AppColors.boGrey2,
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: color,
    );
  }
}
