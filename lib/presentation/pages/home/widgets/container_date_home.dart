import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/constants.dart';
import '../../../../data/date_util.dart';
import '../../transaction/bloc/transaction_bloc.dart';

class ContainerDateHome extends StatelessWidget {
  const ContainerDateHome({
    Key? key,
    required this.stateTheme,
    required this.selectedDate,
  }) : super(key: key);

  final Brightness stateTheme;
  final String selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 10),
      height: MediaQuery.of(context).size.height / 14,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration:
                (stateTheme == Brightness.light) ? arrowDecor : arrowDecorDark,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  String date = DateUtil()
                      .operationDate(selectedDate, OptionDate.days, 0);
                  context
                      .read<TransactionBloc>()
                      .add(ReadTransactionEvent(transactionDateTime: date));
                },
                icon: const Icon(Icons.arrow_left_sharp),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(selectedDate),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(9999))
                  .then((value) {
                if (value != null) {
                  final date = DateUtil().formatedyyyyMMdd(value.toString());
                  context
                      .read<TransactionBloc>()
                      .add(SelectedDateHomeEvent(value: date));
                }
              });
            },
            child: Container(
              decoration: (stateTheme == Brightness.light)
                  ? arrowDecor
                  : arrowDecorDark,
              width: MediaQuery.of(context).size.width / 2,
              height: double.infinity,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    selectedDate,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration:
                (stateTheme == Brightness.light) ? arrowDecor : arrowDecorDark,
            child: IconButton(
              onPressed: () {
                String date =
                    DateUtil().operationDate(selectedDate, OptionDate.days, 1);

                context
                    .read<TransactionBloc>()
                    .add(ReadTransactionEvent(transactionDateTime: date));
              },
              icon: const Icon(Icons.arrow_right_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
