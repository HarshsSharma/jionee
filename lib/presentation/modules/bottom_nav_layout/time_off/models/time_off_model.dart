import 'package:flutter/material.dart';

enum TimeOffRequestStatus {
  pending('Pending', Colors.red),
  approved('Approved', Colors.green);

  final String name;
  final Color color;
  const TimeOffRequestStatus(this.name, this.color);
}

// enum HolidayType {
//   holiday(FontAwesomeIcons.holiday),
//   sick(FontAwesomeIcons.hospital),
//   trip(FontAwesomeIcons.plane);
//   final FontAwesomeIcons icon;
//   const HolidayType(this.icon);
// }

class TimeOffModel {
  final String title;
  final DateTime startData;
  final DateTime endData;
  final DateTime postDate;
  final TimeOffRequestStatus status;
  const TimeOffModel({
    required this.title,
    required this.startData,
    required this.endData,
    required this.postDate,
    required this.status,
  });
}

List<TimeOffModel> timeOffData = [
  TimeOffModel(
    title: 'Holiday',
    startData: DateTime(2019, 10, 1),
    endData: DateTime(2019, 10, 4),
    postDate: DateTime(2019, 9, 14),
    status: TimeOffRequestStatus.pending,
  ),
  TimeOffModel(
    title: 'Holiday',
    startData: DateTime(2019, 10, 10),
    endData: DateTime(2019, 10, 15),
    postDate: DateTime(2019, 10, 1),
    status: TimeOffRequestStatus.pending,
  ),
  TimeOffModel(
    title: 'Sickness Absence',
    startData: DateTime(2019, 9, 15),
    endData: DateTime(2019, 9, 30),
    postDate: DateTime(2019, 8, 19),
    status: TimeOffRequestStatus.approved,
  ),
  TimeOffModel(
    title: 'HD',
    startData: DateTime(2019, 9, 5),
    endData: DateTime(2019, 9, 9),
    postDate: DateTime(2019, 6, 8),
    status: TimeOffRequestStatus.approved,
  ),
  TimeOffModel(
    title: 'HD',
    startData: DateTime(2019, 9, 5),
    endData: DateTime(2019, 9, 9),
    postDate: DateTime(2019, 6, 8),
    status: TimeOffRequestStatus.approved,
  ),
  TimeOffModel(
    title: 'Sickness Absence',
    startData: DateTime(2019, 9, 15),
    endData: DateTime(2019, 9, 30),
    postDate: DateTime(2019, 8, 19),
    status: TimeOffRequestStatus.approved,
  ),
  TimeOffModel(
    title: 'Sickness Absence',
    startData: DateTime(2019, 9, 15),
    endData: DateTime(2019, 9, 30),
    postDate: DateTime(2019, 8, 19),
    status: TimeOffRequestStatus.approved,
  ),
  TimeOffModel(
    title: 'HD',
    startData: DateTime(2019, 9, 5),
    endData: DateTime(2019, 9, 9),
    postDate: DateTime(2019, 6, 8),
    status: TimeOffRequestStatus.approved,
  ),
];
