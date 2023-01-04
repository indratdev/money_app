import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_app/presentation/pages/chart/widgets/showing_detail_section.dart';

import '../../../../data/constants.dart';
import '../../../../data/models/calculation_model.dart';
import '../../../../data/repositories/transaction_repository_impl.dart';

Container ContainerExpense(
  Brightness stateTheme,
  double widthBoxTitle,
  double heightPieChart,
  double widhtPieChart,
  Map<String, dynamic> resultChart,
) {
  return Container(
    decoration: customCircularBox(
      color: (stateTheme == Brightness.light) ? Colors.white60 : blackN,
    ),
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: [
        SizedBox(
          width: widthBoxTitle,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'expense'.tr(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          height: heightPieChart,
          width: widhtPieChart,
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(show: false),
              sectionsSpace: 3,
              centerSpaceRadius: 40,
              sections: showingSections(resultChart, 1),
            ),
            swapAnimationCurve: Curves.easeInOutCubic,
            swapAnimationDuration: const Duration(milliseconds: 1000),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 30),
          height: heightPieChart,
          width: widhtPieChart,
          decoration: customCircularBox(
            color: (stateTheme == Brightness.light
                ? redCalculation
                : redDeepCalculation),
          ),
          child: ShowingDetailSection(resultChart: resultChart, isOutcome: 1),
        ),
      ],
    ),
  );
}

Container ContainerIncomeChart(
  BuildContext context,
  Brightness stateTheme,
  double widthBoxTitle,
  double heightPieChart,
  double widhtPieChart,
  Map<String, dynamic> resultChart,
) {
  return Container(
    decoration: customCircularBox(
      color: (stateTheme == Brightness.light)
          ? lightWhite.withOpacity(0.6)
          : blackN,
    ),
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: [
        SizedBox(
          width: widthBoxTitle,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'income'.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(
          height: heightPieChart,
          width: widhtPieChart,
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(show: true),
              sectionsSpace: 3,
              centerSpaceRadius: 40,
              sections: showingSections(resultChart, 0),
            ),
            swapAnimationCurve: Curves.easeInOutCubic,
            swapAnimationDuration: const Duration(milliseconds: 1000),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 30),
          height: heightPieChart,
          width: widhtPieChart,
          decoration: customCircularBox(
            color: (stateTheme == Brightness.light
                ? greenCalculation
                : greenDeepCalculation),
            // : seagull),
          ),
          child: ShowingDetailSection(resultChart: resultChart, isOutcome: 0),
        ),
      ],
    ),
  );
}

List<PieChartSectionData> showingSections(
    Map<String, dynamic> resultChart, int isOutcome) {
  List<ChartCalculationModel> datas = [];

  if (isOutcome == 1 && resultChart.isNotEmpty) {
    datas = resultChart[TransactionType.expenses.name];
  } else if (isOutcome == 0 && resultChart.isNotEmpty) {
    datas = resultChart[TransactionType.income.name];
  } else {
    datas = [];
  }

  final List<PieChartSectionData> list = [];

  if (datas.isNotEmpty) {
    for (var element in datas) {
      final data = PieChartSectionData(
        color: Color(element.colors).withOpacity(1.0),
        value: element.persentase,
        radius: 40.0,
        titleStyle: const TextStyle(
          // fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      );
      list.add(data);
    }
  }

  if (datas.isEmpty) {
    final data = PieChartSectionData(
      color: Colors.grey.shade400,
      radius: 40.0,
      value: 100,
      showTitle: true,
      titlePositionPercentageOffset: 30.0,
    );
    list.add(data);
  }

  return list;
}
