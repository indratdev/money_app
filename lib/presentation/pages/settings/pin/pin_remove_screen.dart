import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/data/pin_manager.dart';
import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';

import '../../../../data/constants.dart';
import '../../../widgets/customWidgets.dart';
import 'widgets/export_widgets.dart';

class PinRemoveScreen extends StatefulWidget {
  PinRemoveScreen({
    super.key,
  });

  @override
  State<PinRemoveScreen> createState() => _PinRemoveScreenState();
}

class _PinRemoveScreenState extends State<PinRemoveScreen> {
  PinManager pm = PinManager();
  // List<String> _tempPasscode = ['', '', '', '', '', ''];
  List<int> _valuePasscode = [];

  @override
  void initState() {
    super.initState();
  }

  validationPasscode(BuildContext context) {
    // check apa sudah full 6
    if (pm.getPasscodeAlreadFulfilled == true) {
      _valuePasscode = pm.getValuePasscode;

      context
          .read<PinBloc>()
          .add(RemovePasscodeEvent(value: _valuePasscode.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PinBloc, PinState>(
        listener: (context, state) {
          if (state is SuccessRemovePasscode) {
            CustomWidgets.showMessageAlertWithF(
                context, 'pin-remove-success'.tr(), true, () {
              Navigator.pushReplacementNamed(context, AppRoutes.first);
            });
          }
          if (state is FailureRemovePasscode) {
            CustomWidgets.showMessageAlertWithF(
                context, state.messageError.toString(), false, () {
              Navigator.pushReplacementNamed(context, AppRoutes.first);
            });
          }
        },
        child: Column(
          children: [
            StatusPadsIcons(pm: pm),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  TapPasscode(true, '1', OperationPin.number),
                  TapPasscode(true, '2', OperationPin.number),
                  TapPasscode(true, '3', OperationPin.number),
                  TapPasscode(true, '4', OperationPin.number),
                  TapPasscode(true, '5', OperationPin.number),
                  TapPasscode(true, '6', OperationPin.number),
                  TapPasscode(true, '7', OperationPin.number),
                  TapPasscode(true, '8', OperationPin.number),
                  TapPasscode(true, '9', OperationPin.number),
                  TapPasscode(false, 'Cancel', OperationPin.cancel,
                      icon: const Icon(Icons.cancel)),
                  TapPasscode(true, '0', OperationPin.number),
                  TapPasscode(false, 'Backspace', OperationPin.backspace,
                      icon: const Icon(Icons.backspace_outlined)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TapPasscode(bool isNumber, String label, OperationPin operationPin,
      {Icon icon = const Icon(
        Icons.circle,
        color: Colors.transparent,
      )}) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        if (operationPin == OperationPin.number) {
          pm.changePasscode(int.parse(label));
          validationPasscode(context);
          setState(() {});
        } else if (operationPin == OperationPin.backspace) {
          pm.removeDigitPasscode();
          setState(() {});
        } else if (operationPin == OperationPin.cancel) {
          Navigator.pushReplacementNamed(context, AppRoutes.settings);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: lightMildWaters,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 15,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: (isNumber) ? Text(label) : icon,
            ),
          ),
        ),
      ),
    );
  }
}

enum OperationPin { number, backspace, cancel }
