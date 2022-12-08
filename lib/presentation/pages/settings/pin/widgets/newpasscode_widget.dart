import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../config/routes/app_routes.dart';

class NewPasscodeWidget extends StatelessWidget {
  const NewPasscodeWidget({
    Key? key,
    required this.isUsedPincode,
  }) : super(key: key);

  final bool isUsedPincode;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isUsedPincode,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.settPinChange);
        },
        child: Text('choose-pin'.tr()),
      ),
    );
  }
}
