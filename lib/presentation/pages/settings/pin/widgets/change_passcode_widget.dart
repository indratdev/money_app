import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../config/routes/app_routes.dart';

class ChangePasscodeWidget extends StatelessWidget {
  const ChangePasscodeWidget({
    Key? key,
    required this.isUsedPincode,
    required this.widthButton,
  }) : super(key: key);

  final bool isUsedPincode;
  final double widthButton;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isUsedPincode,
      child: SizedBox(
        width: widthButton,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settPinUpdate);
            },
            child: Text('change-pin'.tr())),
      ),
    );
  }
}
