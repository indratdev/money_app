import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/calculation_model.dart';
import '../../../../data/repositories/transaction_repository_impl.dart';

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
