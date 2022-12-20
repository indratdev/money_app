import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/presentation/pages/rekap/bloc/report_bloc.dart';

class ReportScreen_Copy2 extends StatefulWidget {
  const ReportScreen_Copy2({super.key});

  @override
  State<ReportScreen_Copy2> createState() => _ReportScreen_Copy2State();
}

class _ReportScreen_Copy2State extends State<ReportScreen_Copy2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String selectedYear = "";
    List<String> listYearTransaction = [];

    return Scaffold(
      appBar: AppBar(title: Text('report'.tr())),
      body: BlocConsumer<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state is SuccessChangeYearTransaction) {
            selectedYear = state.valueYear;
          }
          if (state is SuccessCheckAllYearTransaction) {
            if (state.result.isNotEmpty) {
              selectedYear = state.result.first;
              listYearTransaction = state.result;
            }
          }
        },
        builder: (context, state) {
          if (state is SuccessCheckAllYearTransaction) {
            if (state.result.isNotEmpty) {
              selectedYear = state.result.first;
              listYearTransaction = state.result;
            }
          }
          return (listYearTransaction.isEmpty)
              ? Center(child: Text('transaction-empty'.tr()))
              : Column(
                  children: <Widget>[
                    // // segment control
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     CupertinoSlidingSegmentedControl<int>(
                    //       backgroundColor: CupertinoColors.lightBackgroundGray,
                    //       thumbColor: Colors.blue,
                    //       padding: const EdgeInsets.all(8),
                    //       groupValue: 0,
                    //       children: {
                    //         0: buildSegmentControl("Penerimaan"),
                    //         1: buildSegmentControl("Pengeluaran"),
                    //       },
                    //       onValueChanged: (value) {
                    //         // context
                    //         //     .read<TransactionBloc>()
                    //         //     .add(SelectedIsOutcomeEvent(value: value ?? 0));
                    //         // transaction.isOutcome = value!;
                    //       },
                    //     ),
                    //   ],
                    // ),
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
                              context.read<ReportBloc>().add(
                                  ChangeYearTransactionEvent(
                                      valueYear: value!));
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

Widget buildSegmentControl(String text) {
  return Container(
    child: Text(
      text,
      style: TextStyle(fontSize: 22, color: Colors.black),
    ),
  );
}
