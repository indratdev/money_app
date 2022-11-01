import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:money_app/data/constants.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/data/repositories/transaction_repository_impl.dart';
import 'package:money_app/domain/entities/calculationE.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/pages/transaction/transaction_manage_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Transaction>? listTransaction;
  List<CalculationE>? listCalculation;

  String selectedDate = ""; // DateUtil().getCurrentDate();

  @override
  Widget build(BuildContext context) {
    var widhtContainer = MediaQuery.of(context).size.width / 4;
    // print("tanggal => $transactionDateTime");
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state is SuccessReadTransaction) {
                listTransaction =
                    state.result[TransactionEnum.transaction.name];
                selectedDate = state.result[TransactionEnum.dateselected.name];
                listCalculation =
                    state.result[TransactionEnum.calculation.name];

                //reload chart
                context.read<ChartBloc>().add(ReadChartDefaultEvent(
                    transactionDateTime: DateUtil().getCurrentDate()));
              }
            },
            builder: (context, state) {
              if (state is SuccessReadTransaction) {
                // listTransaction = state.result;
                listTransaction =
                    state.result[TransactionEnum.transaction.name];
                selectedDate =
                    state.result[TransactionEnum.dateselected.name].toString();
                listCalculation =
                    state.result[TransactionEnum.calculation.name];
                //reload chart
                context.read<ChartBloc>().add(ReadChartDefaultEvent(
                    transactionDateTime: DateUtil().getCurrentDate()));
              }
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 14,
                    color: Colors.grey.shade300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            String date = DateUtil().operationDate(
                                selectedDate, OptionDate.days, 0);
                            context.read<TransactionBloc>().add(
                                ReadTransactionEvent(
                                    transactionDateTime: date));
                          },
                          icon: const Icon(Icons.arrow_left_sharp),
                        ),
                        Text(selectedDate),
                        IconButton(
                          onPressed: () {
                            String date = DateUtil().operationDate(
                                selectedDate, OptionDate.days, 1);

                            context.read<TransactionBloc>().add(
                                ReadTransactionEvent(
                                    transactionDateTime: date));
                          },
                          icon: Icon(Icons.arrow_right_sharp),
                        ),
                      ],
                    ),
                  ),
                  // container calculation
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
                    color: Colors.grey.shade200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                          margin: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height / 5,
                          width: widhtContainer -
                              10, //MediaQuery.of(context).size.width / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("KELUAR"),
                              Text(listCalculation?[0].expense.toString() ??
                                  "0.0"),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          margin: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height / 5,
                          width: widhtContainer -
                              10, //MediaQuery.of(context).size.width / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("TERIMA"),
                              Text(listCalculation?[0].income.toString() ??
                                  "0.0"),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.green,
                          margin: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height / 5,
                          width: widhtContainer -
                              10, //MediaQuery.of(context).size.width / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("Selisih"),
                              Text(listCalculation?[0].profit.toString() ??
                                  "0.0"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(5.0),
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue.shade300, spreadRadius: 4),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        itemCount: listTransaction?.length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Transaction data = listTransaction![index];
                              context.read<CategoryBloc>().add(
                                  ReadCategoryByIdEvent(
                                      idCategory: data.idCategory));
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionManageScreen(
                                            data: data,
                                          )));

                              // print(">>> tapped : ${listTransaction?[index]}");
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              leading: CircleAvatar(
                                radius: 25,
                                foregroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/icons/${listTransaction?[index].categoryIconName}.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              title: Text(
                                  "${listTransaction?[index].title.toString()}"),
                              trailing: Text(
                                "Rp. ${formatterThousand.format(
                                  double.tryParse(
                                      "${listTransaction?[index].amount}"),
                                )}",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
