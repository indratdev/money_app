import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../data/constants.dart';
import '../../../../../domain/entities/transaction.dart';

class ContainerNameTransaction extends StatelessWidget {
  const ContainerNameTransaction({
    Key? key,
    required this.nameController,
    required this.data,
  }) : super(key: key);

  final TextEditingController nameController;
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
          Text('name'.tr()),
          SB_Height10,
          TextFormField(
            controller: nameController..text = data!.title,
            onSaved: (newValue) {
              if (newValue!.isNotEmpty || newValue != "") {
                data!.title = newValue;
              }
            },
            onFieldSubmitted: (value) {
              nameController.text = value;
              data!.title = value;
            },
            validator: (value) {
              if (value!.isEmpty || value == "") {
                return 'name-not-null'.tr();
              }
              return null;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'type-name'.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
