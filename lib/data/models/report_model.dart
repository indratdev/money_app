import 'package:money_app/domain/entities/report.dart';

class ReportModel extends Report {
  String year_month = "";
  double income, expense, profit = 0.0;

  ReportModel({
    required this.year_month,
    required this.income,
    required this.expense,
    required this.profit,
  }) : super(
          year_month: "",
          income: 0.0,
          expense: 0.0,
          profit: 0.0,
        );

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        year_month: json['year_month'] as String? ?? "",
        income: json['income'] as double? ?? 0.0,
        expense: json['expense'] as double? ?? 0.0,
        profit: json['profit'] as double? ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        'year_month': year_month,
        'income': income,
        'expense': expense,
        'profit': profit,
      };
}
