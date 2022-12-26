import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';

import 'widgets/export_widgets.dart';

class PinScreen extends StatelessWidget {
  PinScreen({super.key});

  bool isUsedPincode = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRoutes.first);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('title-pin'.tr()),
        ),
        body: Center(
          child: BlocBuilder<PinBloc, PinState>(
            builder: (context, state) {
              final widhtButton = MediaQuery.of(context).size.width / 2.5;
              if (state is SuccessCheckPinUsed) {
                isUsedPincode = state.result;
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    NewPasscodeWidget(
                      isUsedPincode: isUsedPincode,
                      widthButton: widhtButton,
                    ), // new passcode
                    ChangePasscodeWidget(
                      isUsedPincode: isUsedPincode,
                      widthButton: widhtButton,
                    ), // change passcode
                    RemovePasscodeWidget(
                      isUsedPincode: isUsedPincode,
                      widthButton: widhtButton,
                    ), // remove passcode
                    SB_Height20,
                    const AttentionWidget(), // attention text
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
