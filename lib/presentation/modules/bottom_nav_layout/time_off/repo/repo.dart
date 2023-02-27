import '../models/time_off_model.dart';

abstract class TimeOffServices {
  Future<List<TimeOffModel>> getData();
}

class TimeOffServicesImpl extends TimeOffServices{
   Future<List<TimeOffModel>> _getTimeOffListData() {
    return Future.delayed(
      const Duration(seconds: 3),
      () {
        return timeOffData;
      },
    );
  }

  @override
  Future<List<TimeOffModel>> getData() async {
    List<TimeOffModel> data = await _getTimeOffListData();
    return data;
  }
}
