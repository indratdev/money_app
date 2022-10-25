import 'package:equatable/equatable.dart';

class CalculationE extends Equatable {
  double income, expense, profit = 0.0;

  CalculationE({
    required this.income,
    required this.expense,
    required this.profit,
  });

  @override
  List<Object?> get props => [
        income,
        expense,
        profit,
      ];
}

class ChartCalculation extends Equatable {
  String categoryName = "";
  double amount, persentase = 0.0;
  int colors = 0;

  ChartCalculation({
    required this.categoryName,
    required this.amount,
    required this.persentase,
    required this.colors,
  });

  @override
  List<Object?> get props => [
        categoryName,
        amount,
        persentase,
        colors,
      ];
}
