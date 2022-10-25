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
                          // sections: showingSections2(),
                        ),
                        swapAnimationCurve: Curves.easeInOutCubic,
                        swapAnimationDuration: Duration(milliseconds: 1000),
                      ),
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
                          sections: showingSections2(),
                        ),
                        swapAnimationCurve: Curves.easeInOutCubic,
                        swapAnimationDuration: Duration(milliseconds: 1000),
                      ),
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

  List<PieChartSectionData> showingSections2() {
    var randomColor = (math.Random().nextDouble() * 0xFFFFFF).toInt();
    List<PieChartSectionData> datas = [];

    datas.add(PieChartSectionData(
        value: 40,
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
        color: Color(randomColor).withOpacity(1.0)));
    datas.add(PieChartSectionData(
        value: 10,
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
        color: Color(randomColor).withOpacity(1.0)));

    return datas;
  }

  List<PieChartSectionData> showingSections(
      Map<String, dynamic> resultChart, int isOutcome) {
    // List<ChartCalculationModel> datas = ;

    // List<ChartCalculationModel> datas = [];
    List<ChartCalculationModel> datas =
        resultChart[TransactionType.expenses.name];

    print(">>>>>>> ${resultChart}");

    if (isOutcome == 1) {
      datas = resultChart[TransactionType.expenses.name];
    } else if (isOutcome == 0) {
      datas = resultChart[TransactionType.income.name];
    } else {
      datas = [];
    }

    // if (isOutcome == 1) {
    //   datas = resultChart[TransactionType.expenses.name];
    // } else {
    //   datas = resultChart[TransactionType.income.name];
    // }

    // List

    final List<PieChartSectionData> list = [];

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

    return list;

    // pieData.add(PieChartSectionData(
    //     value: 40,
    //     radius: 50,
    //     titleStyle: TextStyle(
    //       fontSize: 15.0,
    //       fontWeight: FontWeight.bold,
    //       color: const Color(0xffffffff),
    //     ),
    //     color: Color(randomColor).withOpacity(1.0)));

    // if (datass.isNotEmpty) {
    //   for (var element in datass) {
    //     pieData.add(PieChartSectionData(
    //       color: Color(randomColor),
    //       // color: Colors.red,
    //       value: element.persentase,
    //       title: "${element.persentase}%",
    //       radius: 50.0,
    //       titleStyle: TextStyle(
    //         fontSize: 16.0,
    //         fontWeight: FontWeight.bold,
    //         color: const Color(0xffffffff),
    //       ),
    //     ));
    //   }
    // } else {
    //   pieData.add(PieChartSectionData(
    //     color: Color(randomColor),
    //     // color: Colors.red,
    //     value: 0,
    //     title: "Kosong",
    //     radius: 50.0,
    //     titleStyle: TextStyle(
    //       fontSize: 16.0,
    //       fontWeight: FontWeight.bold,
    //       color: const Color(0xffffffff),
    //     ),
    //   ));
    // }

    // print(">>> piedata : ${pieData[0].value}");

    // return pieData;

    // print("==> datas : $datass");

    // return List.generate(4, (i) {
    //   final isTouched = i == touchedIndex;
    //   final fontSize = isTouched ? 25.0 : 16.0;
    //   final radius = isTouched ? 60.0 : 50.0;
    //   switch (i) {
    //     case 0:
    //       return PieChartSectionData(
    //         color: const Color(0xff0293ee),
    //         value: 40,
    //         title: '40%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: const Color(0xffffffff),
    //         ),
    //       );
    //     case 1:
    //       return PieChartSectionData(
    //         color: const Color(0xfff8b250),
    //         value: 30,
    //         title: '30%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: const Color(0xffffffff),
    //         ),
    //       );
    //     case 2:
    //       return PieChartSectionData(
    //         color: const Color(0xff845bef),
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: const Color(0xffffffff),
    //         ),
    //       );
    //     case 3:
    //       return PieChartSectionData(
    //         color: const Color(0xff13d38e),
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: const Color(0xffffffff),
    //         ),
    //       );
    //     default:
    //       throw Error();
    //   }
    // });
  }

  // List<PieChartSectionData> showingSections(Map<String, dynamic>? resultChart) {
  //   return List.generate(4, (i) {
  //     final isTouched = i == touchedIndex;
  //     final fontSize = isTouched ? 25.0 : 16.0;
  //     final radius = isTouched ? 60.0 : 50.0;
  //     switch (i) {
  //       case 0:
  //         return PieChartSectionData(
  //           color: const Color(0xff0293ee),
  //           value: 40,
  //           title: '40%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: const Color(0xffffffff),
  //           ),
  //         );
  //       case 1:
  //         return PieChartSectionData(
  //           color: const Color(0xfff8b250),
  //           value: 30,
  //           title: '30%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: const Color(0xffffffff),
  //           ),
  //         );
  //       case 2:
  //         return PieChartSectionData(
  //           color: const Color(0xff845bef),
  //           value: 15,
  //           title: '15%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: const Color(0xffffffff),
  //           ),
  //         );
  //       case 3:
  //         return PieChartSectionData(
  //           color: const Color(0xff13d38e),
  //           value: 15,
  //           title: '15%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: const Color(0xffffffff),
  //           ),
  //         );
  //       default:
  //         throw Error();
  //     }
  //   });
  // }
}
