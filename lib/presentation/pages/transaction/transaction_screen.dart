import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../../../data/constants.dart';
import '../settings/category/bloc/category_bloc.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Transaction transaction =
        Transaction(idCategory: 0, title: "", createdTime: todayTime);

    // int? groupValue = 0;
    // DateTime? dateTime;
    // String selectedImage = "collect-interest";

    // final halfMediaWidth = MediaQuery.of(context).size.width - 10;
    // final mediaHeight = MediaQuery.of(context).size.height / 3;
    // var today = DateTime.now().toString;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaksi"),
      ),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is SuccessSelectedIsOutcome) {
            transaction.isOutcome = state.result;
          }
          if (state is SuccessSelectedDate) {
            transaction.createdTime = state.result;
          }
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  // section form
                  Flexible(
                    flex: 9,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // segement control
                          CupertinoSlidingSegmentedControl<int>(
                            backgroundColor:
                                CupertinoColors.lightBackgroundGray,
                            thumbColor: Colors.blue,
                            padding: const EdgeInsets.all(8),
                            groupValue: transaction.isOutcome,
                            children: {
                              0: buildSegment("Penerimaan"),
                              1: buildSegment("Pengeluaran"),
                            },
                            onValueChanged: (value) {
                              context.read<TransactionBloc>().add(
                                  SelectedIsOutcomeEvent(value: value ?? 0));
                              transaction.isOutcome = value!;
                            },
                          ),
                          SB_Height20,

                          // tanggal
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Tanggal"),
                              InkWell(
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(9999))
                                      .then((value) {
                                    context.read<TransactionBloc>().add(
                                        SelectedDateEvent(
                                            value: value.toString()));
                                  });
                                },
                                child: ListTile(
                                  title: Text(defaultDateTimeF
                                      .format(
                                          transaction.createdTime as DateTime)
                                      .toString()),
                                  trailing: Icon(Icons.calendar_month),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  // section button
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Simpan"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSegment(String text) {
  return Container(
    child: Text(
      text,
      style: TextStyle(fontSize: 22, color: Colors.black),
    ),
  );
}
