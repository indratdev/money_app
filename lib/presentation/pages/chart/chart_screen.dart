import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';

import '../../../data/date_util.dart';
import '../../../data/repositories/transaction_repository_impl.dart';
import 'dart:math' as math;

class ChartScreen extends StatelessWidget {
  ChartScreen({super.key});

  int touchedIndex = -1;
  String selectedDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan"),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ChartBloc, ChartState>(
          listener: (context, state) {
            if (state is SuccessReadChartDefault) {
              selectedDate = state.result[TransactionEnum.dateselected.name];
              print("selecteddate listener : $selectedDate");
            }
          },
          builder: (context, state) {
            if (state is SuccessReadChartDefault) {
              selectedDate = state.result[TransactionEnum.dateselected.name];
              print("selecteddate : $selectedDate");
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
                          String date = DateUtil()
                              .operationDate(selectedDate, OptionDate.month, 0);
                          context.read<ChartBloc>().add(
                              ReadChartDefaultEvent(transactionDateTime: date));
                        },
                        icon: Icon(Icons.arrow_left_sharp),
                      ),
                      Text((selectedDate == ""
                          ? DateUtil().currentDate
                          : DateUtil().formatedMMMyyy(selectedDate))),
                      // Text(selectedDate),
                      // Text(DateUtil().formatedMMMyyy((selectedDate == "")
                      //     ? DateUtil().currentDate
                      //     : selectedDate)),
                      IconButton(
                        onPressed: () {
                          String date = DateUtil()
                              .operationDate(selectedDate, OptionDate.month, 1);
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
                          sections: showingSections(),
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

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
