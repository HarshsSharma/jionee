import 'package:flutter/material.dart';
import '../../constants/extensions/data_formates.dart';

import '../modules/bottom_nav_layout/time_off/models/time_off_model.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${duration.inDays} days (${data.startData.dateFormateToddMMMyy()} - ${data.endData.dateFormateToddMMMyy()})',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    child: Text(
                      data.status.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: data.status.color),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.startData.dateFormateToddMMMyy(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
