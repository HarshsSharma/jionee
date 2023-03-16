import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jionee/common/enums/time_off.dart';
import 'package:jionee/common/extensions/loader.dart';
import 'package:jionee/common/extensions/strings.dart';

import '../models/time_off_model.dart';
import '../repo/repo.dart';

class TimeOffViewModel with ChangeNotifier {
  final TimeOffServices myService;
  TimeOffViewModel(this.myService);
  final List<TimeOffModel> _data = [];
  TimeOffModel? _selectedRequest;
  TextInputType _dataKeyboradType = TextInputType.text;

  List<TimeOffModel> get data => _data;
  TimeOffModel get selectedRequest => _selectedRequest!;
  TextInputType get dataKeyboradType => _dataKeyboradType;

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

  void changeDataKeyboardType(String text) {
    if (text.isNotEmpty) {
      if (text.lastChar().isNumeric()) {
        _changeDataKeyboardType(TextInputType.phone);
      } else {
        _changeDataKeyboardType(TextInputType.text);
      }
    } else {
      _changeDataKeyboardType(TextInputType.text);
    }
  }

  void _changeDataKeyboardType(TextInputType inputType) {
    log('TextInputType: $inputType');
    _dataKeyboradType = inputType;
    notifyListeners();
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

  Future<void> getData(BuildContext context) async {
    try {
      context.showLoader();

      List<TimeOffModel> response = await myService.getData();
      if (context.mounted) {
        Future.delayed(const Duration(seconds: 1), () => context.hideLoader());
      }
      _addNewData(response);
    } catch (e) {
      context.hideLoader();
      context.showErrorLoader(() {});
    }
  }
}
