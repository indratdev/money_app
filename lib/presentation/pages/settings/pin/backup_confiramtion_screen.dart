import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../../data/constants.dart';
import '../../../../data/pin_manager.dart';

class PinConfirmationScreenBackup extends StatefulWidget {
  final List<int> valuePasscodeBefore;

  PinConfirmationScreenBackup({
    super.key,
    this.valuePasscodeBefore = const [],
  });

  @override
  State<PinConfirmationScreenBackup> createState() =>
      _PinConfirmationScreenBackupState();
}

class _PinConfirmationScreenBackupState
    extends State<PinConfirmationScreenBackup> {
  PinManager pm = PinManager();
  List<String> tempPasscode = ['', '', '', '', '', ''];
  List<int> valuePasscode = [];

  @override
  void initState() {
    super.initState();

    print(">>lemparan valuePasscodeBefore : ${widget.valuePasscodeBefore}");
  }

  changePasscode(int value) {
    if (valuePasscode.length < 6) {
      valuePasscode.add(value);
      tempPasscode[valuePasscode.length - 1] = value.toString(); //update tempp
      setState(() {}); // refresh
    }

    // passcode already 6
    if (valuePasscode.length == pm.getMaxLengthPasscode) {
      if (pm.isValidPasscode(widget.valuePasscodeBefore, valuePasscode)) {
        print("samaaaa");
      } else {
        CustomWidgets.showMessageAlertBasic(
            context, "Passcode Tidak Sama", false);
      }
    }

    // pm.isValidPasscode(widget.valuePasscodeBefore, valuePasscode);
    // if (valuePasscode.length == 6) {
    //   //check
    //   isValidPasscode(widget.valuePasscodeBefore, valuePasscode);
    // }
  }

  // isValidPasscode(List<int> before, List<int> now) {
  //   // Function eq = const ListEquality().equals;
  //   // // print(eq([1, 'two', 3], [1, 'two', 3])); // => true
  //   // print(eq(before, now)); // => true
  //   // print("before : $before");
  //   // print("now : $now");
  //   // var aaa = eq

  //   // if (before == now) {
  //   //   print(">>> SAMA");
  //   // } else {
  //   //   print(">>> Ga sama");
  //   // }
  // }

  removeDigitPasscode() {
    if (valuePasscode.isNotEmpty) {
      valuePasscode.removeLast();
      tempPasscode[valuePasscode.length] = '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('confirm-pincode'.tr())),
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
                TapPasscode(true, '1', OperationPin.number),
                TapPasscode(true, '2', OperationPin.number),
                TapPasscode(true, '3', OperationPin.number),
                TapPasscode(true, '4', OperationPin.number),
                TapPasscode(true, '5', OperationPin.number),
                TapPasscode(true, '6', OperationPin.number),
                TapPasscode(true, '7', OperationPin.number),
                TapPasscode(true, '8', OperationPin.number),
                TapPasscode(true, '9', OperationPin.number),
                TapPasscode(false, 'More', OperationPin.more,
                    icon: const Icon(Icons.more_horiz_sharp)),
                TapPasscode(true, '0', OperationPin.number),
                TapPasscode(false, 'Cancel', OperationPin.cancel,
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
          changePasscode(int.parse(label));
        } else if (operationPin == OperationPin.cancel) {
          removeDigitPasscode();
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

enum OperationPin { number, cancel, more }
