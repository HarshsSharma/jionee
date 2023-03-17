import 'package:flutter/material.dart';

import '../models/employees_data.dart';

class EvaluationsViewModel extends ChangeNotifier {
  List<int> _selectedEmployess = [];
  EmployeeModel? _selectedEmployee;

  List<int> get selectedEmployess => _selectedEmployess;
  EmployeeModel get selectedEmployee => _selectedEmployee!;

  void selectEmployee(EmployeeModel employee) {
    _selectedEmployee = employee;
  }

  bool isSelcted(EmployeeModel employee) {
    return _selectedEmployess.contains(employee.id);
  }

  void addToSelectedEmployess(EmployeeModel employee) {
    if (_selectedEmployess.contains(employee.id)) {
      removeFromSelectedEmployees(employee);
    } else {
      _selectedEmployess.add(employee.id);
      notifyListeners();
    }
  }

  void removeFromSelectedEmployees(EmployeeModel employee) {
    _selectedEmployess.removeWhere((element) => element == employee.id);
    notifyListeners();
  }

  void unSelectAll() {
    _selectedEmployess = [];
    notifyListeners();
  }
}
