import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

class PinScreen extends StatelessWidget {
  PinScreen({super.key});

  bool isUsedPincode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title-pin'.tr()),
      ),
      body: Center(
        child: BlocBuilder<PinBloc, PinState>(
          builder: (context, state) {
            if (state is SuccessCheckPinUsed) {
              isUsedPincode = state.result;
            }
            return Column(
              children: <Widget>[
                // new passcode
                Visibility(
                  visible: !isUsedPincode,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.settPinChange);
                    },
                    child: Text(
                      'choose-pin'.tr(),
                    ),
                  ),
                ),

                // change passcode
                Visibility(
                  visible: isUsedPincode,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.settPinUpdate);
                      },
                      child: Text('change-pin'.tr())),
                ),

                // remove passcode
                Visibility(
                  visible: isUsedPincode,
                  child: ElevatedButton(
                    onPressed: () {
                      CustomWidgets.showConfirmationWithF(
                          context, 'pin-remove-confirmation'.tr(), () {
                        Navigator.pushNamed(context, AppRoutes.settPinRemove);
                      });
                    },
                    child: Text(
                      'remove-pin'.tr(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: 'pin-information'.tr(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 18),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
