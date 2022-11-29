import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/constants.dart';
import '../../../../../domain/entities/transaction.dart';
import '../../bloc/transaction_bloc.dart';

class ContainerDateTransaction extends StatelessWidget {
  const ContainerDateTransaction({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Transaction? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(8),
      decoration: customCircularBox(color: Colors.white.withOpacity(0.9)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(fit: BoxFit.fitWidth, child: Text('date'.tr())),
          InkWell(
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(data!.createdTime),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(9999))
                  .then((value) {
                (value == null)
                    ? context
                        .read<TransactionBloc>()
                        .add(SelectedDateEvent(value: data!.createdTime))
                    : context
                        .read<TransactionBloc>()
                        .add(SelectedDateEvent(value: value.toString()));
              });
            },
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(
                DateFormat('dd / MM / yyyy').format(
                  DateTime.parse(data!.createdTime),
                ),
              ),
              trailing: const Icon(Icons.arrow_drop_down_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
