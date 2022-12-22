import 'package:equatable/equatable.dart';

class Report extends Equatable {
  String year_month = "";
  double income, expense, profit = 0.0;

  Report({
    required this.year_month,
    required this.income,
    required this.expense,
    required this.profit,
  });

  @override
  List<Object?> get props => [
        year_month,
        income,
        expense,
        profit,
      ];
}
