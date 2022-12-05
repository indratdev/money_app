import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/data/pin_manager.dart';
import 'package:money_app/presentation/pages/settings/pin/pin_confirmation_screen.dart';

import '../../../../data/constants.dart';

class PinRemoveScreen extends StatefulWidget {
  PinRemoveScreen({
    super.key,
  });

  @override
  State<PinRemoveScreen> createState() => _PinRemoveScreenState();
}

class _PinRemoveScreenState extends State<PinRemoveScreen> {
  PinManager pm = PinManager();
  List<String> _tempPasscode = ['', '', '', '', '', ''];
  List<int> _valuePasscode = [];

  @override
  void initState() {
    // print("tempPasscode : $tempPasscode");
    super.initState();
  }

  validationPasscode() {
    // check apa sudah full 6
    if (pm.getPasscodeAlreadFulfilled == true) {
      print("datanya : ${pm.getValuePasscode}");
      pm.removePasscode();
    }
  }

  // nextPageConfirmation() {
  //   if (pm.getPasscodeAlreadFulfilled == true) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) =>
  //             PinConfirmationScreen(valuePasscodeBefore: pm.getValuePasscode),
  //       ),
  //     );
  //   }
  // }

  // changePasscode(int value) {
  //   if (valuePasscode.length < pm.getMaxLengthPasscode) {
  //     valuePasscode.add(value);
  //     tempPasscode[valuePasscode.length - 1] = value.toString(); //update tempp
  //     setState(() {}); // refresh
  //   }

  // passcode already 6
  //   if (valuePasscode.length == pm.getMaxLengthPasscode) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) =>
  //             PinConfirmationScreen(valuePasscodeBefore: valuePasscode),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('choose-pin'.tr())),
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
                      children:
                          // _buildCircles(),
                          <Widget>[
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
    );
  }

  TapPasscode(bool isNumber, String label, OperationPin operationPin,
      {Icon icon = const Icon(Icons.circle)}) {
    return InkWell(
      onTap: () {
        if (operationPin == OperationPin.number) {
          pm.changePasscode(int.parse(label));
          // _valuePasscode.add(int.parse(label));
          // _tempPasscode[_valuePasscode.length - 1] =
          //     int.parse(label).toString(); //update tempp

          validationPasscode();
          setState(() {});
        } else if (operationPin == OperationPin.backspace) {
          pm.removeDigitPasscode();
          // _valuePasscode.removeLast();
          // _tempPasscode[_valuePasscode.length] = '';
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
