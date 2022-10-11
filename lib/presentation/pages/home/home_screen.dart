import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          print(">>>>> listener $state");
          if (state is SuccessSaveTransactionNew) {
            // print(">>> show");
            // CustomWidgets.showMessageAlertBasic(
            //     context, "Data Berhasil Ditambahkan");
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Data Berhasil Ditambahkan")));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Center(child: Text("Home")),
            ],
          );
        },
      ),
    );
  }
}
