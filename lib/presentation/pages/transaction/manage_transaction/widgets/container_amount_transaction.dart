import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../data/constants.dart';
import '../../../../../domain/entities/transaction.dart';

class ContainerAmountTransaction extends StatelessWidget {
  const ContainerAmountTransaction({
    Key? key,
    required this.amountController,
    required this.data,
  }) : super(key: key);

  final TextEditingController amountController;
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
          Text('amount'.tr()),
          SB_Height10,
          TextFormField(
            keyboardType: TextInputType.number,
            controller: amountController..text = data!.amount.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              hintText: "0",
            ),
            onSaved: (newValue) {
              if (newValue!.isNotEmpty || newValue != "") {
                data!.amount = double.parse(newValue);
              }
            },
            onFieldSubmitted: (value) {
              amountController.text = value;
              data!.amount = double.parse(value);
            },
          ),
        ],
      ),
    );
  }
}
