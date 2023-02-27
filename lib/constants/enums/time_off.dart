enum TimeOffType {
  sick('Sick'),
  holiday('Holiday'),
  plane('Plane');

  final String vlaue;
  const TimeOffType(this.vlaue);
}

enum TimeOffDayPart {
  single('Single Day'),
  multi('Multi Day');

  final String value;
  const TimeOffDayPart(this.value);
}
