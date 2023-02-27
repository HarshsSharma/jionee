import 'package:flutter/material.dart';
import '../../constants/extensions/data_formates.dart';

import '../modules/bottom_nav_layout/time_off/models/time_off_model.dart';
import '../styles/fonts_theme.dart';

class TimeOffItemBuilder extends StatelessWidget {
  const TimeOffItemBuilder({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);
  final TimeOffModel data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Duration duration = data.endData.difference(data.startData);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: timeOffTitleListTile(),
                ),
                const SizedBox(height: 8),
                Text(
                  '${duration.inDays} days (${data.startData.dateFormateToddMMMyy()} - ${data.endData.dateFormateToddMMMyy()})',
                  style: timeOffDateTimeTextStyle(),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.status.name,
                  style: timeOffTitleListTile(data.status.color),
                ),
                const SizedBox(height: 8),
                Text(
                  data.startData.dateFormateToddMMMyy(),
                  style: timeOffDateTimeTextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
