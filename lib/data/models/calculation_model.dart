import 'package:money_app/domain/entities/calculationE.dart';

class CalculationModel extends CalculationE {
  double income, expense, profit = 0.0;

  CalculationModel({
    required this.income,
    required this.expense,
    required this.profit,
  }) : super(
          income: 0.0,
          expense: 0.0,
          profit: 0.0,
        );

  factory CalculationModel.fromJson(Map<String, dynamic> json) =>
      CalculationModel(
        income: json['income'] as double? ?? 0.0,
        expense: json['expense'] as double? ?? 0.0,
        profit: json['profit'] as double? ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        'income': income,
        'expense': expense,
        'profit': profit,
      };
}
