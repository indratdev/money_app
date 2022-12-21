import 'package:intl/intl.dart';

enum OptionDate {
  days,
  month,
  years,
}

enum OptionFirstLast {
  first,
  last,
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
    DateFormat formatter = DateFormat('yyyy-MM-dd'); // 2021-12-25
    return formatter.format(DateTime.parse(date)).toString();
  }

  String formatedyyyyMM(String date) {
    DateFormat formatter = DateFormat('yyyy-MM'); // 2021-12
    return formatter.format(DateTime.parse(date)).toString();
  }

  String formatedddMMyyyy(String date) {
    DateFormat formatter = DateFormat('dd/MM/yyyy'); // 25/12/2021
    return formatter.format(DateTime.parse(date)).toString();
  }

  String formatedMMMyyy(String date) {
    DateFormat formatter = DateFormat('MMMM yyy'); // December 2021
    return formatter.format(DateTime.parse(date)).toString();
  }

  String formatedddMMMyyyy(String date) {
    DateFormat formatter = DateFormat('dd MMM yyyy'); // 01 Des 2021
    return formatter.format(DateTime.parse(date)).toString();
  }

  // String operationDate2(String date, int isIncrement) {
  //   // if isIncement = 1 => plus date 1 day
  //   // if isIncement = 0 => minus date 1 day
  //   DateTime datees = DateTime.parse(date);
  //   String myDate =
  //       datees.add(Duration(days: (isIncrement == 1) ? 1 : -1)).toString();
  //   return formatedyyyyMMdd(myDate);
  // }

  String operationDate(String date, OptionDate option, int isIncrement) {
    // if isIncement = 1 => plus date 1 day
    // if isIncement = 0 => minus date 1 day
    DateTime datees = DateTime.parse(date);
    String myDate = "";

    // days
    if (option.name == OptionDate.days.name) {
      myDate =
          datees.add(Duration(days: (isIncrement == 1) ? 1 : -1)).toString();
    }

    // month
    if (option.name == OptionDate.month.name) {
      myDate =
          datees.add(Duration(days: (isIncrement == 1) ? 30 : -30)).toString();
    }

    return formatedyyyyMMdd(myDate);
  }
}

class DateOperation extends DateUtil {
  List<int> listMonth = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  Map<int, dynamic> getFirstLastDay(int year) {
    Map<int, dynamic> result = {};

    for (var props in listMonth) {
      DateTime firstDayMonth = DateTime.utc(year, props, 1);
      DateTime lastDayMonth =
          DateTime.utc(year, props + 1).subtract(const Duration(days: 1));
      // print("first : ${firstDayMonth} - last : ${lastDayMonth}");
      result[props] = {
        OptionFirstLast.first: firstDayMonth,
        OptionFirstLast.last: lastDayMonth,
      };
    }
    // print(result);
    return result;
  }
}
