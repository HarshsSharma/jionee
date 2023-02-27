import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/extensions/data_formates.dart';

import '../view_model/time_off_view_model.dart';

class TimeOffItemDetails extends StatelessWidget {
  const TimeOffItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TimeOffViewModel data = Provider.of<TimeOffViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(data.selectedRequest.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowWithText(
              title: 'Status',
              trailingColor: data.selectedRequest.status.color,
              trailingTitle: data.selectedRequest.status.name,
            ),
            RowWithText(
              title: 'Start Date',
              trailingTitle:
                  data.selectedRequest.startData.dateFormateToddMMMyy(),
            ),
            RowWithText(
              title: 'End Date',
              trailingTitle:
                  data.selectedRequest.endData.dateFormateToddMMMyy(),
            ),
          ],
        ),
      ),
    );
  }
}

class RowWithText extends StatelessWidget {
  const RowWithText({
    Key? key,
    required this.title,
    required this.trailingTitle,
    this.trailingColor = Colors.grey,
  }) : super(key: key);
  final String title;
  final String trailingTitle;
  final Color trailingColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            trailingTitle,
            style: TextStyle(
              fontSize: 16.0,
              color: trailingColor,
            ),
          ),
        ],
      ),
    );
  }
}
