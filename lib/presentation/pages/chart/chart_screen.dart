import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';
import 'package:money_app/presentation/pages/chart/widgets/container_date_chart.dart';
import 'package:money_app/presentation/pages/chart/widgets/container_expense.dart';

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

    double widthBoxTitle = MediaQuery.of(context).size.width / 2.5;
    double heightPieChart = MediaQuery.of(context).size.height / 4;
    double widhtPieChart = MediaQuery.of(context).size.width / 1.30;

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
                  context, state.messageError.toString(), false);
            }

            if (state is SuccessReadChartDefault) {
              selectedDate = state.result[TransactionEnum.dateselected.name];
            }
          },
          builder: (context, state) {
            if (state is FailureReadChartDefault) {
              CustomWidgets.showMessageAlertBasic(
                  context, state.messageError.toString(), false);
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
                  // container tanggal
                  ContainerDateChart(
                      stateTheme: stateTheme,
                      dates: dates,
                      selectedDate: selectedDate),
                  SB_Height10,
                  // container income
                  ContainerIncomeChart(context, stateTheme, widthBoxTitle,
                      heightPieChart, widhtPieChart, resultChart),
                  SB_Height30,
                  // container outcome
                  ContainerExpense(stateTheme, widthBoxTitle, heightPieChart,
                      widhtPieChart, resultChart),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
