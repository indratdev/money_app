import 'package:intl/intl.dart';

class DateUtil {
  String currentDate;

  DateUtil({this.currentDate = ""});

  String getCurrentDate() {
    DateTime current = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(current).toString();
  }
}
