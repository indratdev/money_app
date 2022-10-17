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
