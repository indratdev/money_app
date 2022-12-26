import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../../data/constants.dart';
import '../../../../data/pin_manager.dart';

class PinConfirmationScreen extends StatefulWidget {
  final List<int> valuePasscodeBefore;

  PinConfirmationScreen({
    super.key,
    this.valuePasscodeBefore = const [],
  });

  @override
  State<PinConfirmationScreen> createState() => _PinConfirmationScreenState();
}

class _PinConfirmationScreenState extends State<PinConfirmationScreen> {
  PinManager pm = PinManager();
  List<String> tempPasscode = ['', '', '', '', '', ''];
  List<int> valuePasscode = [];
  int countTry = 0;

  @override
  void initState() {
    super.initState();
  }

  resetPm() {
    tempPasscode = ['', '', '', '', '', ''];
    valuePasscode = [];
  }

  changePasscode(int value) {
    if (valuePasscode.length < pm.getMaxLengthPasscode) {
      valuePasscode.add(value);
      tempPasscode[valuePasscode.length - 1] = value.toString(); //update tempp
      setState(() {}); // refresh
    }

    // passcode already 6
    if (valuePasscode.length == pm.getMaxLengthPasscode) {
      var isValid =
          pm.isValidPasscode(widget.valuePasscodeBefore, valuePasscode);
      if (isValid[PinString.isValidPasscode.toString()] == true) {
        context.read<PinBloc>().add(SavingPasscodeEvent(
            value: isValid[PinString.valueEncryptDecryptPasscode.toString()]));
      } else {
        countTry += 1;
        CustomWidgets.showMessageAlertBasic(
            context, 'wrong-passcode'.tr(), false);
        resetPm();
      }

      if (countTry == 3) {
        CustomWidgets.showMessageAlertWithF(
            context, 'passcode-warning-try'.tr(), false, () {
          Navigator.pushReplacementNamed(context, AppRoutes.first);
        });
      }
    }
  }

  removeDigitPasscode() {
    if (valuePasscode.isNotEmpty) {
      valuePasscode.removeLast();
      tempPasscode[valuePasscode.length] = '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        body: BlocListener<PinBloc, PinState>(
          listener: (context, state) {
            if (state is SuccessSavingPasscode) {
              CustomWidgets.showMessageAlertWithF(
                  context, 'passcode-save-success'.tr(), true, () {
                Navigator.pushReplacementNamed(context, AppRoutes.first);
              });
            }
          },
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'confirm-pincode'.tr(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              // _buildCircles(),
                              <Widget>[
                            (tempPasscode[0] == '')
                                ? const Icon(Icons.circle_outlined)
                                : const Icon(Icons.circle_rounded),
                            (tempPasscode[1] == '')
                                ? const Icon(Icons.circle_outlined)
                                : const Icon(Icons.circle_rounded),
                            (tempPasscode[2] == '')
                                ? const Icon(Icons.circle_outlined)
                                : const Icon(Icons.circle_rounded),
                            (tempPasscode[3] == '')
                                ? const Icon(Icons.circle_outlined)
                                : const Icon(Icons.circle_rounded),
                            (tempPasscode[4] == '')
                                ? const Icon(Icons.circle_outlined)
                                : const Icon(Icons.circle_rounded),
                            (tempPasscode[5] == '')
                                ? const Icon(Icons.circle_outlined)
                                : const Icon(Icons.circle_rounded),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    TapPasscode(true, '1', OperationPin.number, stateTheme),
                    TapPasscode(true, '2', OperationPin.number, stateTheme),
                    TapPasscode(true, '3', OperationPin.number, stateTheme),
                    TapPasscode(true, '4', OperationPin.number, stateTheme),
                    TapPasscode(true, '5', OperationPin.number, stateTheme),
                    TapPasscode(true, '6', OperationPin.number, stateTheme),
                    TapPasscode(true, '7', OperationPin.number, stateTheme),
                    TapPasscode(true, '8', OperationPin.number, stateTheme),
                    TapPasscode(true, '9', OperationPin.number, stateTheme),
                    TapPasscode(
                        false, 'Cancel', OperationPin.cancel, stateTheme,
                        icon: const Icon(Icons.cancel_outlined)),
                    TapPasscode(true, '0', OperationPin.number, stateTheme),
                    TapPasscode(
                        false, 'Backspace', OperationPin.backspace, stateTheme,
                        icon: const Icon(Icons.backspace_outlined)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TapPasscode(bool isNumber, String label, OperationPin operationPin,
      Brightness stateTheme,
      {Icon icon = const Icon(Icons.circle)}) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        if (operationPin == OperationPin.number) {
          changePasscode(int.parse(label));
        } else if (operationPin == OperationPin.backspace) {
          removeDigitPasscode();
        } else if (operationPin == OperationPin.cancel) {
          Navigator.pushReplacementNamed(context, AppRoutes.settPin);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: (stateTheme == Brightness.light) ? lightMildWaters : charcoal,
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

enum OperationPin { number, cancel, backspace }
