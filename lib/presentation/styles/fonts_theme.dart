import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle _getTextStyle({
  required double fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle timeOffTitleListTile([Color? color]) {
  return _getTextStyle(
    fontSize: 18.0,
    color: color,
    fontWeight: FontWeight.bold,
  );
}

TextStyle timeOffDateTimeTextStyle() {
  return _getTextStyle(
    fontSize: 16.0,
    color: Colors.grey,
  );
}

TextStyle labelTextStyle() {
  return _getTextStyle(
    fontSize: 16.0,
    color: AppColors.tDarkGrey,
  );
}

TextStyle timeOffValueTextStyle() {
  return _getTextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );
}
