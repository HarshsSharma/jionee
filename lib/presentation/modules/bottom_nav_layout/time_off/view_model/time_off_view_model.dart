import 'package:flutter/material.dart';

import '../../../../../constants/enums/time_off.dart';
import '../models/time_off_model.dart';
import '../repo/repo.dart';

class TimeOffViewModel with ChangeNotifier {
  final TimeOffServices myService;
  TimeOffViewModel(this.myService);
  final List<TimeOffModel> _data = [];
  TimeOffModel? _selectedRequest;

  List<TimeOffModel> get data => _data;
  TimeOffModel get selectedRequest => _selectedRequest!;

  TextEditingController typeController = TextEditingController();
  TextEditingController dayPartController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController requestMessageController = TextEditingController();

  void init() {
    typeController = TextEditingController();
    dayPartController = TextEditingController();
    dateController = TextEditingController();
    requestMessageController = TextEditingController();
  }

  List<TimeOffType> timeOffTypes = [
    TimeOffType.holiday,
    TimeOffType.plane,
    TimeOffType.sick,
    TimeOffType.holiday,
    TimeOffType.plane,
    TimeOffType.sick,
    TimeOffType.holiday,
    TimeOffType.plane,
  ];
  List<TimeOffDayPart> timeOffDayPart = [
    TimeOffDayPart.multi,
    TimeOffDayPart.single,
  ];

  void disposeT() {
    typeController.dispose();
    dateController.dispose();
    dayPartController.dispose();
    requestMessageController.dispose();
  }

  void setSelectedRequest(TimeOffModel request) {
    _selectedRequest = request;
  }

  void setTypeControllerText(String value) {
    typeController.text = value;
  }

  void setDayPartControllerText(String value) {
    dayPartController.text = value;
  }

  void setDateControllerText(String value) {
    dateController.text = value;
  }

  void setRequestMessageControllerText(String value) {
    requestMessageController.text = value;
  }

  void _addNewData(List<TimeOffModel> newData) {
    _data.addAll(newData);
    notifyListeners();
  }

  Future<void> getData() async {
    List<TimeOffModel> response = await myService.getData();
    _addNewData(response);
  }
}
