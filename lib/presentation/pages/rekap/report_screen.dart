import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/presentation/pages/rekap/bloc/report_bloc.dart';

import '../../../data/constants.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String selectedYear = "";
  List<String> listYearTransaction = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('report'.tr()),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // context.read<ReportBloc>().add(CheckAllYearTransactionEvent());
              // DateOperation().getFirstLastDay(2021);
              context
                  .read<ReportBloc>()
                  .add(GenerateReportByYearEvent(year: '2021'));
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocConsumer<ReportBloc, ReportState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is SuccessCheckAllYearTransaction) {
            if (state.result.isNotEmpty) {
              selectedYear = state.result.first;
              listYearTransaction = state.result;
            }
          }

          if (state is SuccessChangeYearTransaction) {
            if (state.valueYear.isNotEmpty) {
              selectedYear = state.valueYear;
            }
          }
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton(
                    value: selectedYear,
                    items: listYearTransaction.map((list) {
                      return DropdownMenuItem(
                        value: list.toString(),
                        child: Text(list.toString()),
                      );
                    }).toList(),
                    onTap: () {
                      context
                          .read<ReportBloc>()
                          .add(CheckAllYearTransactionEvent());
                    },
                    onChanged: (String? value) {
                      if (value != "") {
                        context
                            .read<ReportBloc>()
                            .add(ChangeYearTransactionEvent(valueYear: value!));
                      }
                    },
                  )
                ],
              ),
              SB_Height30,
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.grey.shade400,
              ),
            ],
          );
        },
      ),
    );
  }
}
