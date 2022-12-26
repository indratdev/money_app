import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/domain/entities/report.dart';
import 'package:money_app/presentation/pages/report/bloc/report_bloc.dart';
import 'package:money_app/presentation/pages/report/widgets/detail_report_yearly.dart';
import 'package:money_app/presentation/widgets/no_data_widget.dart';

import '../../../data/constants.dart';
import '../../widgets/customWidgets.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String selectedYear = "";
  List<String> listYearTransaction = [];
  List<Report> listReport = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('report'.tr()),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              context.read<ReportBloc>().add(CheckAllYearTransactionEvent());
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocConsumer<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state is FailureChangeYearTransaction) {
            CustomWidgets.showMessageAlertBasic(
                context, 'report-year-failedLoad'.tr(), false);
          }

          if (state is FailureGenerateReportByYear) {
            CustomWidgets.showMessageAlertBasic(
                context, 'report-failedLoad'.tr(), false);
          }

          if (state is SuccessChangeYearTransaction) {
            if (state.valueYear.isNotEmpty) {
              selectedYear = state.valueYear;
            }
          }
        },
        builder: (context, state) {
          if (state is FailureChangeYearTransaction) {
            CustomWidgets.showMessageAlertBasic(
                context, 'report-year-failedLoad'.tr(), false);
          }

          if (state is FailureGenerateReportByYear) {
            CustomWidgets.showMessageAlertBasic(
                context, 'report-failedLoad'.tr(), false);
          }

          if (state is LoadingGenerateReportByYear) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is SuccessChangeYearTransaction) {
            if (state.valueYear.isNotEmpty) {
              selectedYear = state.valueYear;
            }
          }

          if (state is SuccessGenerateReportByYear) {
            listReport = state.resultReport;
          }

          if (state is SuccessCheckAllYearTransaction) {
            if (state.result.isNotEmpty) {
              selectedYear = state.result.first;
              context
                  .read<ReportBloc>()
                  .add(GenerateReportByYearEvent(year: selectedYear));
              listYearTransaction = state.result;
            }
          }

          return (listYearTransaction.isNotEmpty)
              ? Column(
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
                          onChanged: (String? value) {
                            if (value != "") {
                              context.read<ReportBloc>()
                                ..add(ChangeYearTransactionEvent(
                                    valueYear: value!))
                                ..add(GenerateReportByYearEvent(year: value));
                            }
                          },
                        )
                      ],
                    ),
                    SB_Height20,
                    DetailReportYearly(listReport: listReport),
                  ],
                )
              : const NoDataWidget();
        },
      ),
    );
  }
}
