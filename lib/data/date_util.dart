import 'package:intl/intl.dart';

class DateUtil {
  String currentDate;

  DateUtil({this.currentDate = ""});

  String getCurrentDate() {
    DateTime current = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(current).toString();
  }

  String formatedyyyyMMdd(String date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(DateTime.parse(date)).toString();
  }

  String operationDate(String date, int isIncrement) {
    // if isIncement = 1 => plus date 1 day
    // if isIncement = 0 => minus date 1 day
    DateTime datees = DateTime.parse(date);
    String myDate =
        datees.add(Duration(days: (isIncrement == 1) ? 1 : -1)).toString();
    return formatedyyyyMMdd(myDate);
  }
}
