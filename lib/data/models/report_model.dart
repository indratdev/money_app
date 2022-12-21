// class ReportModel extends CalculationModel {
//   String firstDayLastDay = "";

//   ReportModel({
//     required this.firstDayLastDay,
//     required super.income,
//     required super.expense,
//     required super.profit,
//   });

//   factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
//         firstDayLastDay: json['firstDayLastDay'] as String? ?? "",
//         income: json['income'] as double? ?? 0.0,
//         expense: json['expense'] as double? ?? 0.0,
//         profit: ['profit'] as double? ?? 0.0,
//       );

//   // ReportModel(
//   //   // firstDayLastDay: json['firstDayLastDay'] as String? ?? "",
//   //   income: json['income'] as double? ?? 0.0,
//   //   expense: json['expense'] as double? ?? 0.0,
//   //   profit: json['profit'] as double? ?? 0.0,
//   // );

//   Map<String, dynamic> toJson() => {
//         'firstDayLastDay': firstDayLastDay,
//         'income': income,
//         'expense': expense,
//         'profit': profit,
//       };
// }

class ReportModel {
  String firstDayLastDay = "";
  double income, expense, profit = 0.0;

  ReportModel({
    required this.firstDayLastDay,
    required this.income,
    required this.expense,
    required this.profit,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        firstDayLastDay: json['firstDayLastDay'] as String? ?? "",
        income: json['income'] as double? ?? 0.0,
        expense: json['expense'] as double? ?? 0.0,
        profit: ['profit'] as double? ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        'firstDayLastDay': firstDayLastDay,
        'income': income,
        'expense': expense,
        'profit': profit,
      };
}
