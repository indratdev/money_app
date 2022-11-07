import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_app/data/constants.dart';

class RekapScreen extends StatelessWidget {
  const RekapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('report'.tr())),
      body: Column(
        children: <Widget>[
          // segment control
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoSlidingSegmentedControl<int>(
                backgroundColor: CupertinoColors.lightBackgroundGray,
                thumbColor: Colors.blue,
                padding: const EdgeInsets.all(8),
                groupValue: 0,
                children: {
                  0: buildSegmentControl("Penerimaan"),
                  1: buildSegmentControl("Pengeluaran"),
                },
                onValueChanged: (value) {
                  // context
                  //     .read<TransactionBloc>()
                  //     .add(SelectedIsOutcomeEvent(value: value ?? 0));
                  // transaction.isOutcome = value!;
                },
              ),
            ],
          ),
          SB_Height30,
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width - 20,
            color: Colors.grey.shade400,
          ),
        ],
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
