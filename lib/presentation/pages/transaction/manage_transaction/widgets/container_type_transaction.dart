import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/transaction.dart';
import '../../bloc/transaction_bloc.dart';
import '../transaction_manage_screen.dart';

class ContainerTypeTransaction extends StatelessWidget {
  const ContainerTypeTransaction({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Transaction? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor: Colors.white.withOpacity(0.9),
        thumbColor: (data!.isOutcome == 0)
            ? Colors.green.shade200
            : Colors.redAccent.shade200,
        //Colors.blue,
        padding: const EdgeInsets.all(8),
        groupValue: data!.isOutcome,
        children: {
          0: buildSegmentComponent('income'.tr()),
          1: buildSegmentComponent('expense'.tr()),
        },
        onValueChanged: (value) {
          context
              .read<TransactionBloc>()
              .add(SelectedIsOutcomeEvent(value: value ?? 0));
          data!.isOutcome = value!;
        },
      ),
    );
  }
}
