import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/data/models/calculation_model.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';

import '../../../data/date_util.dart';
import '../../../data/repositories/transaction_repository_impl.dart';
import '../../widgets/customWidgets.dart';

class ChartScreen extends StatelessWidget {
  ChartScreen({super.key});

  DateUtil dates = DateUtil();
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;

    String selectedDate = dates.currentDate;
    Map<String, dynamic> resultChart = {};

    return Scaffold(
      appBar: AppBar(
        title: Text('chart'.tr()),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ChartBloc, ChartState>(
          listener: (context, state) {
            if (state is FailureReadChartDefault) {
              CustomWidgets.showMessageAlertBasic(
                  context, 'error-read-chart'.tr(), false);
            }

            if (state is SuccessReadChartDefault) {
              selectedDate = state.result[TransactionEnum.dateselected.name];
            }
          },
          builder: (context, state) {
            if (state is FailureReadChartDefault) {
              CustomWidgets.showMessageAlertBasic(
                  context, 'error-read-chart'.tr(), false);
            }

            if (state is SuccessReadChartDefault) {
              selectedDate = state.result[TransactionEnum.dateselected.name];
              resultChart[TransactionType.expenses.name] =
                  state.result[TransactionType.expenses.name];
              resultChart[TransactionType.income.name] =
                  state.result[TransactionType.income.name];
            }

            return Container(
              decoration: (stateTheme == Brightness.light)
                  ? backgroundThemeLight
                  : backgroundThemeDark,
              child: Column(
                children: <Widget>[
                  // // container tanggal
                  Container(
                    margin: const EdgeInsets.only(
                        top: 8, right: 8, left: 8, bottom: 25),
                    height: MediaQuery.of(context).size.height / 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: (stateTheme == Brightness.light)
                              ? arrowDecor
                              : arrowDecorDark,
                          child: IconButton(
                            onPressed: () {
                              String date = dates.operationDate(
                                  selectedDate, OptionDate.month, 0);
                              context.read<ChartBloc>().add(
                                  ReadChartDefaultEvent(
                                      transactionDateTime: date));
                            },
                            icon: const Icon(Icons.arrow_left_sharp),
                          ),
                        ),
                        Container(
                          decoration: (stateTheme == Brightness.light)
                              ? arrowDecor
                              : arrowDecorDark,
                          width: MediaQuery.of(context).size.width / 2,
                          height: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Text(
                                (selectedDate == ""
                                    ? dates.currentDate
                                    : dates.formatedMMMyyy(selectedDate)),
                                softWrap: true,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: (stateTheme == Brightness.light)
                              ? arrowDecor
                              : arrowDecorDark,
                          child: IconButton(
                            onPressed: () {
                              String date = dates.operationDate(
                                  selectedDate, OptionDate.month, 1);
                              context.read<ChartBloc>().add(
                                  ReadChartDefaultEvent(
                                      transactionDateTime: date));
                            },
                            icon: const Icon(Icons.arrow_right_sharp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SB_Height10,
                  Container(
                    decoration: customCircularBox(
                        color: (stateTheme == Brightness.light)
                            ? Colors.white60
                            : lightPurple),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Text(
                          'income'.tr(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          width: 300,
                          // color: (stateTheme == Brightness.light)
                          //     ? Colors.white60
                          //     : Colors.red,
                          child: PieChart(
                            PieChartData(
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 3,
                              centerSpaceRadius: 40,
                              sections: showingSections(resultChart, 0),
                            ),
                            swapAnimationCurve: Curves.easeInOutCubic,
                            swapAnimationDuration: Duration(milliseconds: 1000),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 30, top: 10, right: 30, bottom: 30),
                          height: 200,
                          width: 300,
                          decoration: customCircularBox(
                              color: (stateTheme == Brightness.light
                                  ? lightWhite
                                  : seagull)),
                          child: ShowingDetailSection(
                              resultChart: resultChart, isOutcome: 0),
                        ),
                      ],
                    ),
                  ),

                  SB_Height30,
                  Container(
                    // decoration: customCircularBox(),
                    decoration: customCircularBox(
                        color: (stateTheme == Brightness.light)
                            ? Colors.white60
                            : lightPurple),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Text(
                          'expense'.tr(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          width: 300,
                          child: PieChart(
                            PieChartData(
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 3,
                              centerSpaceRadius: 40,
                              sections: showingSections(resultChart, 1),
                            ),
                            swapAnimationCurve: Curves.easeInOutCubic,
                            swapAnimationDuration:
                                const Duration(milliseconds: 1000),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, top: 10, right: 30, bottom: 30),
                          height: 200,
                          width: 300,
                          decoration: customCircularBox(
                              color: (stateTheme == Brightness.light
                                  ? lightWhite
                                  : seagull)),
                          child: ShowingDetailSection(
                              resultChart: resultChart, isOutcome: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
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
}

class ShowingDetailSection extends StatelessWidget {
  ShowingDetailSection({
    Key? key,
    required this.resultChart,
    required this.isOutcome,
  }) : super(key: key);

  Map<String, dynamic> resultChart = {};
  int isOutcome = 0;

  List<ChartCalculationModel> datas = [];

  @override
  Widget build(BuildContext context) {
    if (isOutcome == 1 && resultChart.isNotEmpty) {
      datas = resultChart[TransactionType.expenses.name];
    } else if (isOutcome == 0 && resultChart.isNotEmpty) {
      datas = resultChart[TransactionType.income.name];
    } else {
      datas = [];
    }

    return (datas.isNotEmpty)
        ? ListView.builder(
            itemCount: datas.length,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                horizontalTitleGap: 5,
                leading: Icon(Icons.circle_rounded,
                    color: Color(datas[index].colors).withOpacity(1.0)),
                title: Text(
                    "${datas[index].categoryName} - (${datas[index].persentase} %)"),
              );
            },
          )
        : Center(
            child: Text('no-data'.tr()),
          );
  }
}
