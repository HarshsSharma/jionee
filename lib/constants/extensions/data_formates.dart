import 'package:intl/intl.dart';

extension DateFormateExtensions on DateTime {
  String dateFormateToddMMMyy() {
    return DateFormat('dd-MMM-yy').format(this);
  }
}
