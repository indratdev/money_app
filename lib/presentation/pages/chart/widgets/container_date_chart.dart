import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/constants.dart';
import '../../../../data/date_util.dart';
import '../bloc/chart_bloc.dart';

class ContainerDateChart extends StatelessWidget {
  const ContainerDateChart({
    Key? key,
    required this.stateTheme,
    required this.dates,
    required this.selectedDate,
  }) : super(key: key);

  final Brightness stateTheme;
  final DateUtil dates;
  final String selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 25),
      height: MediaQuery.of(context).size.height / 14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration:
                (stateTheme == Brightness.light) ? arrowDecor : arrowDecorDark,
            child: IconButton(
              onPressed: () {
                String date =
                    dates.operationDate(selectedDate, OptionDate.month, 0);
                context
                    .read<ChartBloc>()
                    .add(ReadChartDefaultEvent(transactionDateTime: date));
              },
              icon: const Icon(Icons.arrow_left_sharp),
            ),
          ),
          Container(
            decoration:
                (stateTheme == Brightness.light) ? arrowDecor : arrowDecorDark,
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
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Container(
            decoration:
                (stateTheme == Brightness.light) ? arrowDecor : arrowDecorDark,
            child: IconButton(
              onPressed: () {
                String date =
                    dates.operationDate(selectedDate, OptionDate.month, 1);
                context
                    .read<ChartBloc>()
                    .add(ReadChartDefaultEvent(transactionDateTime: date));
              },
              icon: const Icon(Icons.arrow_right_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
