import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../data/constants.dart';
import '../../../data/date_util.dart';

class ClearDataScreen extends StatelessWidget {
  const ClearDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('clear-data-all'.tr()),
      ),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is SuccessDeleteAllData) {
            CustomWidgets.showMessageAlertWithF(
                context, 'success-clear-data-all'.tr(), true, () {
              context.read<TransactionBloc>().add(ReadTransactionEvent(
                  transactionDateTime: DateUtil().getCurrentDate()));
              context.read<ChartBloc>().add(ReadChartDefaultEvent(
                  transactionDateTime: DateUtil().getCurrentDate()));
              Navigator.pop(context);
            });
          }
          if (state is FailureDeleteAllData) {
            CustomWidgets.showMessageAlertBasic(
                context, 'failed-clear-data-all'.tr(), false);
          }
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text.rich(
                textAlign: TextAlign.justify,
                overflow: TextOverflow.clip,
                softWrap: true,
                TextSpan(
                    text: 'confirm-clear-data-all'.tr(),
                    style: const TextStyle(height: 1.5)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: lightBlue),
                onPressed: () {
                  CustomWidgets.showConfirmationDelete(
                      context, 'confirm-delete-all'.tr(), () {
                    Navigator.of(context).pop();
                    context.read<TransactionBloc>().add(DeleteAllData());
                  });
                },
                child: Text(
                  'delete'.tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
