class MonthlyEvaluationData {
  final String month;
  final String title;
  final double percent;
  const MonthlyEvaluationData({
    required this.month,
    required this.title,
    required this.percent,
  });
}

List<MonthlyEvaluationData> monthlyEvData = const [
  MonthlyEvaluationData(
    month: 'October',
    percent: 0,
    title: 'Office Presence',
  ),
  MonthlyEvaluationData(
    month: 'September',
    percent: 76,
    title: 'Job Execution',
  ),
];