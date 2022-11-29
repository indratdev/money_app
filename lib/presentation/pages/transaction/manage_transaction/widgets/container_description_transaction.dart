import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../data/constants.dart';
import '../../../../../domain/entities/transaction.dart';

class ContainerDescriptionTransaction extends StatelessWidget {
  const ContainerDescriptionTransaction({
    Key? key,
    required this.deskriptionController,
    required this.data,
  }) : super(key: key);

  final TextEditingController deskriptionController;
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
          Text('description'.tr()),
          SB_Height10,
          TextFormField(
            keyboardType: TextInputType.text,
            controller: deskriptionController..text = data?.description ?? "",
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'type-description'.tr(),
            ),
            onSaved: (newValue) {
              data!.description = newValue ?? "";
            },
            onFieldSubmitted: (value) {
              deskriptionController.text = value;
              data!.description = value;
            },
          ),
        ],
      ),
    );
  }
}
