import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/data/repositories/transaction_repository_impl.dart';
import 'package:money_app/domain/entities/calculationE.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/pages/transaction/transaction_manage_screen.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
              if (state is SuccessUpdateTransaction) {
                CustomWidgets.showMessageAlertBasic(
                    context, "Transaksi Berhasil Diperbaharui");
              }
              if (state is SuccessDeleteTransaction) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Data Berhasil dihapus")));
              }

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
                    color: Colors.amber,
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
                          icon: Icon(Icons.arrow_left_sharp),
                        ),
                        Text(selectedDate),
                        IconButton(
                          onPressed: () {
                            String date = DateUtil().operationDate(
                                selectedDate, OptionDate.days, 1);
                            print(">>>>> dateeee : $date");
                            context.read<TransactionBloc>().add(
                                ReadTransactionEvent(
                                    transactionDateTime: date));
                          },
                          icon: Icon(Icons.arrow_right_sharp),
                        ),
                      ],
                    ),
                  ),
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
                    child: ListView.builder(
                      itemCount: listTransaction?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Transaction data = listTransaction![index];
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) =>
                            //       TransactionManageScreen(data: data),
                            // ));
                            // Navigator.pushNamed(
                            //     context, AppRoutes.transactionManage,
                            //     arguments: data);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TransactionManageScreen(
                            //             data: data,
                            //           )),
                            //   (Route<dynamic> route) => false,
                            // );
                            // Navigator.of(
                            //   context,
                            //   rootNavigator: false,
                            // ).pushNamed(AppRoutes.transactionManage,
                            //     arguments: data);
                            // Navigator.of(context).pushNamed(
                            //     AppRoutes.transactionManage,
                            //     arguments: data);
                            // PersistentNavBarNavigator.pushNewScreen(context,
                            //     screen: TransactionManageScreen(
                            //       data: data,
                            //     ));
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             TransactionManageScreen(
                            //               data: data,
                            //             )),
                            //     (route) => false);
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        TransactionManageScreen(
                                          data: data,
                                        )));

                            print(">>> tapped : ${listTransaction?[index]}");
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
