import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';

import 'widgets/export_widgets.dart';

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
                NewPasscodeWidget(isUsedPincode: isUsedPincode), // new passcode
                ChangePasscodeWidget(
                    isUsedPincode: isUsedPincode), // change passcode
                RemovePasscodeWidget(
                    isUsedPincode: isUsedPincode), // remove passcode
                const AttentionWidget(), // attention text
              ],
            );
          },
        ),
      ),
    );
  }
}
