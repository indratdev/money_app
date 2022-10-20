import 'package:intl/intl.dart';

enum OptionDate {
  days,
  month,
  years,
}

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

  String formatedMMMyyy(String date) {
    print(">>>>> formatedMMMyyy : $date");
    DateFormat formatter = DateFormat('MMMM yyy');
    return formatter.format(DateTime.parse(date)).toString();
  }

  String operationDate2(String date, int isIncrement) {
    // if isIncement = 1 => plus date 1 day
    // if isIncement = 0 => minus date 1 day
    DateTime datees = DateTime.parse(date);
    String myDate =
        datees.add(Duration(days: (isIncrement == 1) ? 1 : -1)).toString();
    return formatedyyyyMMdd(myDate);
  }

  String operationDate(String date, OptionDate option, int isIncrement) {
    // if isIncement = 1 => plus date 1 day
    // if isIncement = 0 => minus date 1 day
    DateTime datees = DateTime.parse(date);
    String myDate = "";

    // days
    if (option.name == OptionDate.days.name) {
      myDate =
          datees.add(Duration(days: (isIncrement == 1) ? 1 : -1)).toString();
      // myDate = formatedyyyyMMdd(myDate);
    }

    // month
    if (option.name == OptionDate.month.name) {
      myDate =
          datees.add(Duration(days: (isIncrement == 1) ? 30 : -30)).toString();

      // myDate = formatedyyyyMMdd(date);
      print("Mydateeee : $myDate");
    }

    return formatedyyyyMMdd(myDate);
  }
}
