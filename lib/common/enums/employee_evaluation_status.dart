enum EmployeeEvaluationStatus {
  excellent('Excellent'),
  veryGood('Very Good'),
  satisfactory('Satisfactory'),
  unsatisfactory('Unsatisfactory'),
  tooEarly('Cannot Rate (Too Early)'),
  noInformation('Cannot Rate (No Information)'),
  unknown('Unknown');

  final String title;
  const EmployeeEvaluationStatus(this.title);
}
