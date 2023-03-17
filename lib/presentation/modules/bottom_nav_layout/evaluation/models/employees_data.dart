import '../../../../../common/enums/employee_evaluation_status.dart';

class EmployeeModel {
  final int id;
  final String name;
  final String jobTitle;
  final String department;
  final String country;
  final EmployeeEvaluationStatus evaluationStatus;
  const EmployeeModel({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.department,
    required this.country,
    required this.evaluationStatus,
  });
}

List<EmployeeModel> employeesData = const [
  EmployeeModel(
    id: 1,
    name: 'Henry Pierce',
    country: 'BG (RS)',
    department: 'Administration',
    jobTitle: 'Office Manager',
    evaluationStatus: EmployeeEvaluationStatus.excellent,
  ),
  EmployeeModel(
    id: 2,
    name: 'Jakayla Walters',
    country: 'PO (SK)',
    department: 'Q&A',
    jobTitle: 'Tester',
    evaluationStatus: EmployeeEvaluationStatus.noInformation,
  ),
  EmployeeModel(
    id: 3,
    name: 'Luke Shah',
    country: 'BLR (IN)',
    department: 'Development',
    jobTitle: 'Software Developer',
    evaluationStatus: EmployeeEvaluationStatus.satisfactory,
  ),
  EmployeeModel(
    id: 4,
    name: 'Lailah Burton',
    country: 'BG (RS)',
    department: 'Design',
    jobTitle: 'Designer',
    evaluationStatus: EmployeeEvaluationStatus.tooEarly,
  ),
  EmployeeModel(
    id: 5,
    name: 'Roland Phelps',
    country: 'TR (SK)',
    department: 'HR',
    jobTitle: 'HR Assistant',
    evaluationStatus: EmployeeEvaluationStatus.unknown,
  ),
  EmployeeModel(
    id: 6,
    name: 'Dalia Higgins',
    country: 'NI (SK)',
    department: 'Development',
    jobTitle: 'Developer',
    evaluationStatus: EmployeeEvaluationStatus.unsatisfactory,
  ),
  EmployeeModel(
    id: 7,
    name: 'Oliver Kaiser',
    country: 'BG (RS)',
    department: 'Q&A',
    jobTitle: 'Analyst/Support',
    evaluationStatus: EmployeeEvaluationStatus.veryGood,
  ),
  EmployeeModel(
    id: 8,
    name: 'Roland Phelps',
    country: 'TR (SK)',
    department: 'HR',
    jobTitle: 'HR Assistant',
    evaluationStatus: EmployeeEvaluationStatus.satisfactory,
  ),
  EmployeeModel(
    id: 9,
    name: 'Roland Phelps',
    country: 'TR (SK)',
    department: 'HR',
    jobTitle: 'HR Assistant',
    evaluationStatus: EmployeeEvaluationStatus.excellent,
  ),
];
