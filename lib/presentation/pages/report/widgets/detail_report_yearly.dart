import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../data/constants.dart';
import '../../../../data/date_util.dart';
import '../../../../domain/entities/report.dart';

class DetailReportYearly extends StatelessWidget {
  const DetailReportYearly({
    Key? key,
    required this.listReport,
  }) : super(key: key);

  final List<Report> listReport;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 15, right: 15),
        itemCount: listReport.length,
        itemBuilder: (context, index) {
          var data = listReport[index];
          var dateMonth = '${listReport[index].year_month}-01';
          dateMonth = DateUtil().formatedMMMyyy(dateMonth);
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: arrowDecor,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(dateMonth),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('expense'.tr(), textAlign: TextAlign.left),
                      SizedBox(
                        child: Text(data.expense.toString()),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('income'.tr(), textAlign: TextAlign.left),
                      SizedBox(
                        child: Text(data.income.toString()),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('deviation'.tr(), textAlign: TextAlign.left),
                      SizedBox(
                        child: Text(data.profit.toString()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
