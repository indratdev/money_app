import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/data/pin_manager.dart';
import 'package:money_app/presentation/pages/settings/pin/pin_confirmation_screen.dart';

import '../../../../data/constants.dart';

class PinChangeScreen extends StatefulWidget {
  PinChangeScreen({
    super.key,
  });

  @override
  State<PinChangeScreen> createState() => _PinChangeScreenState();
}

class _PinChangeScreenState extends State<PinChangeScreen> {
  PinManager pm = PinManager();
  List<String> _tempPasscode = ['', '', '', '', '', ''];
  List<int> _valuePasscode = [];

  @override
  void initState() {
    super.initState();
  }

  nextPageConfirmation() {
    if (pm.getPasscodeAlreadFulfilled == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PinConfirmationScreen(valuePasscodeBefore: pm.getValuePasscode),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        body: Column(
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
                        'enter-pincode'.tr(),
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
                        children: <Widget>[
                          (pm.getTempPasscode[0] == '')
                              ? const Icon(Icons.circle_outlined)
                              : const Icon(Icons.circle_rounded),
                          (pm.getTempPasscode[1] == '')
                              ? const Icon(Icons.circle_outlined)
                              : const Icon(Icons.circle_rounded),
                          (pm.getTempPasscode[2] == '')
                              ? const Icon(Icons.circle_outlined)
                              : const Icon(Icons.circle_rounded),
                          (pm.getTempPasscode[3] == '')
                              ? const Icon(Icons.circle_outlined)
                              : const Icon(Icons.circle_rounded),
                          (pm.getTempPasscode[4] == '')
                              ? const Icon(Icons.circle_outlined)
                              : const Icon(Icons.circle_rounded),
                          (pm.getTempPasscode[5] == '')
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
                  TapPasscode(false, 'More', OperationPin.more, stateTheme,
                      icon: const Icon(Icons.more_horiz_sharp)),
                  TapPasscode(true, '0', OperationPin.number, stateTheme),
                  TapPasscode(false, 'Cancel', OperationPin.cancel, stateTheme,
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
      Brightness stateTheme,
      {Icon icon = const Icon(
        Icons.circle,
        color: Colors.transparent,
      )}) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        if (operationPin == OperationPin.number) {
          pm.changePasscode(int.parse(label));
          nextPageConfirmation();
          setState(() {});
        } else if (operationPin == OperationPin.cancel) {
          pm.removeDigitPasscode();
          setState(() {});
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

enum OperationPin { number, cancel, more }
