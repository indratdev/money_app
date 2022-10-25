import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/data/models/calculation_model.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';

import '../../../data/date_util.dart';
import '../../../data/repositories/transaction_repository_impl.dart';
import 'dart:math' as math;

import '../../../domain/entities/calculationE.dart';

class ChartScreen extends StatelessWidget {
  ChartScreen({super.key});

  DateUtil dates = DateUtil();
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    String selectedDate = dates.currentDate;
    Map<String, dynamic> resultChart = {};
    // List<ChartCalculation>? resultChart;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan"),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ChartBloc, ChartState>(
          listener: (context, state) {
            if (state is SuccessReadChartDefault) {
              selectedDate = state.result[TransactionEnum.dateselected.name];
            }
          },
          builder: (context, state) {
            if (state is SuccessReadChartDefault) {
              selectedDate = state.result[TransactionEnum.dateselected.name];
              resultChart[TransactionType.expenses.name] =
                  state.result[TransactionType.expenses.name];
              resultChart[TransactionType.income.name] =
                  state.result[TransactionType.income.name];

              print("==>==> ${state.result[TransactionType.expenses.name]}");
              // print("@@==>==> ${state.result}");
              // print("@@==>==> ${resultChart}");
            }

            return Column(
              children: <Widget>[
                // container tanggal
                Container(
                  height: MediaQuery.of(context).size.height / 14,
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          String date = dates.operationDate(
                              selectedDate, OptionDate.month, 0);
                          context.read<ChartBloc>().add(
                              ReadChartDefaultEvent(transactionDateTime: date));
                        },
                        icon: Icon(Icons.arrow_left_sharp),
                      ),
                      Text((selectedDate == ""
                          ? dates.currentDate
                          : dates.formatedMMMyyy(selectedDate))),
                      IconButton(
                        onPressed: () {
                          String date = dates.operationDate(
                              selectedDate, OptionDate.month, 1);
                          context.read<ChartBloc>().add(
                              ReadChartDefaultEvent(transactionDateTime: date));
                        },
                        icon: Icon(Icons.arrow_right_sharp),
                      ),
                    ],
                  ),
                ),
                SB_Height20,
                Column(
                  children: [
                    Text("Pendapatan"),
                    SizedBox(
                      height: 200,
                      width: 300,
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ShowingDetailSection(
                          resultChart: resultChart, isOutcome: 0),
                    ),
                  ],
                ),

                SB_Height20,
                Column(
                  children: [
                    Text("Pengeluaran"),
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
                        swapAnimationDuration: Duration(milliseconds: 1000),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30, top: 10, right: 30, bottom: 30),
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ShowingDetailSection(
                          resultChart: resultChart, isOutcome: 1),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      Map<String, dynamic> resultChart, int isOutcome) {
    List<ChartCalculationModel> datas = [];

    print(">>>>>>> ${resultChart}");

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
          titleStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );
        list.add(data);
      }
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

    return ListView.builder(
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
    );
  }
}
