import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../data/constants.dart';
import '../../../../../data/pin_manager.dart';
import '../../../../widgets/customWidgets.dart';
import '../bloc/pin_bloc.dart';

class PinUpdateScreen extends StatefulWidget {
  PinUpdateScreen({
    super.key,
    // this.status = StatusRemoveScreen.update,
  });

  @override
  State<PinUpdateScreen> createState() => _PinUpdateScreenState();
}

class _PinUpdateScreenState extends State<PinUpdateScreen> {
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
          .add(CheckPasscodeEvent(value: _valuePasscode.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        body: BlocListener<PinBloc, PinState>(
          listener: (context, state) {
            if (state is SuccessCheckPasscode) {
              Future.delayed(
                  const Duration(milliseconds: 500),
                  () => Navigator.pushReplacementNamed(
                      context, AppRoutes.settPinChange));
            }
            if (state is FailureCheckPasscodeStatus) {
              CustomWidgets.showMessageAlertWithF(
                  context, state.messageError, false, () {
                Navigator.pushReplacementNamed(context, AppRoutes.settings);
              });
            }
            if (state is FailureCheckPasscode) {
              CustomWidgets.showMessageAlertWithF(
                  context, state.messageError.toString(), false, () {
                Navigator.pushReplacementNamed(context, AppRoutes.settings);
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
                          'update-pin-type-old-pin'.tr(),
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
                        icon: const Icon(Icons.cancel)),
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

enum OperationPin { number, backspace, cancel }
