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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: bloomColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: BlocConsumer<TransactionBloc, TransactionState>(
              listener: (context, state) {
                if (state is SuccessReadTransaction) {
                  listTransaction =
                      state.result[TransactionEnum.transaction.name];
                  selectedDate =
                      state.result[TransactionEnum.dateselected.name];
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
                  selectedDate = state.result[TransactionEnum.dateselected.name]
                      .toString();
                  listCalculation =
                      state.result[TransactionEnum.calculation.name];
                  //reload chart
                  context.read<ChartBloc>().add(ReadChartDefaultEvent(
                      transactionDateTime: DateUtil().getCurrentDate()));
                }
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 8, right: 8, left: 8, bottom: 25),
                      height: MediaQuery.of(context).size.height / 14,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            decoration: arrowDecor,
                            child: IconButton(
                              onPressed: () {
                                String date = DateUtil().operationDate(
                                    selectedDate, OptionDate.days, 0);
                                context.read<TransactionBloc>().add(
                                    ReadTransactionEvent(
                                        transactionDateTime: date));
                              },
                              icon: const Icon(Icons.arrow_left_sharp),
                            ),
                          ),
                          Container(
                            decoration: arrowDecor,
                            width: MediaQuery.of(context).size.width / 2,
                            height: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                selectedDate,
                                softWrap: true,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            decoration: arrowDecor,
                            child: IconButton(
                              onPressed: () {
                                String date = DateUtil().operationDate(
                                    selectedDate, OptionDate.days, 1);

                                context.read<TransactionBloc>().add(
                                    ReadTransactionEvent(
                                        transactionDateTime: date));
                              },
                              icon: const Icon(Icons.arrow_right_sharp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // container calculation
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(27),
                            bottomLeft: Radius.circular(27),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, -5),
                                blurRadius: 8.0)
                          ]),
                      height: MediaQuery.of(context).size.height / 10,
                      margin: EdgeInsets.only(
                          top: 8, bottom: 25, left: 10, right: 10),
                      // color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            // color: Colors.red,
                            // margin: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height / 5,
                            width: widhtContainer -
                                10, //MediaQuery.of(context).size.width / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: const Text(
                                    "Pengeluaran",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  listCalculation?[0].expense.toString() ??
                                      "0.0",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.blue,
                            // margin: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height / 5,
                            width: widhtContainer -
                                10, //MediaQuery.of(context).size.width / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: const Text(
                                    "Penerimaan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  listCalculation?[0].income.toString() ??
                                      "0.0",
                                  style:
                                      TextStyle(color: Colors.green.shade600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.green,
                            // margin: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height / 5,
                            width: widhtContainer -
                                10, //MediaQuery.of(context).size.width / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: const Text(
                                    "Selisih",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
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
                              topRight: Radius.circular(35),
                              bottomRight: Radius.circular(5.0),
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0)),
                          color: lightMildWaters,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF50A7D9),
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        // margin: EdgeInsets.only(top: 20),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.black26),
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
      ),
    );
  }
}
