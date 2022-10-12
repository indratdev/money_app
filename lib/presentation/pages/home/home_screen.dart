import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Transaction>? listTransaction;

  String transactionDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    print("tanggal => $transactionDateTime");
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is SuccessReadTransaction) {
                listTransaction = state.result;
              }
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_left_sharp),
                        ),
                        Text("2022-10-12"),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_right_sharp),
                        ),
                      ],
                    ),
                    color: Colors.amber,
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
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("PENGELUARAN"),
                              Text("0"),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          margin: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("PENERIMAAN"),
                              Text("0"),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.green,
                          margin: EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("SALDO"),
                              Text("0"),
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
                        return ListTile(
                          contentPadding: EdgeInsets.all(8),
                          leading: CircleAvatar(
                            radius: 25,
                            foregroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.asset(
                                // 'assets/icons/${listTransaction?[index].}.png',
                                'assets/icons/${listTransaction?[index].categoryIconName}.png',
                                fit: BoxFit.fill,
                                // color: Colors.transparent,
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
