import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../../../config/routes/app_routes.dart';

class RemovePasscodeWidget extends StatelessWidget {
  const RemovePasscodeWidget({
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
            CustomWidgets.showConfirmationWithF(
                context, 'pin-remove-confirmation'.tr(), () {
              Navigator.pushNamed(context, AppRoutes.settPinRemove);
            });
          },
          child: Text('remove-pin'.tr()),
        ),
      ),
    );
  }
}
