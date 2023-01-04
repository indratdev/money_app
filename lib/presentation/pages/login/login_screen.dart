import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/login/bloc/login_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../../../data/constants.dart';
import '../../../data/pin_manager.dart';
import '../../widgets/customWidgets.dart';
import '../settings/pin/pin_remove_screen.dart';
import '../settings/pin/widgets/status_pads_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PinManager pm = PinManager();
  List<int> _valuePasscode = [];
  bool isVisible = false;

  validationPasscode(BuildContext context) {
    // check apa sudah full 6
    if (pm.getPasscodeAlreadFulfilled == true) {
      _valuePasscode = pm.getValuePasscode;
      context
          .read<LoginBloc>()
          .add(LoginWithPasscodeEvent(value: _valuePasscode.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;
    // check passcode
    checkPinCode(bool status) {
      if (status == false) {
        Future.delayed(
          Duration.zero,
          () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.first, (route) => false);
          },
        );
      } else {
        isVisible = true;
      }
    }

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is SuccessLoginWithPasscode) {
              Navigator.pushReplacementNamed(context, AppRoutes.first);
            }
            if (state is PasscodeFailedLoginWithPasscode) {
              CustomWidgets.showMessageAlertWithF(
                  context, 'login-failed'.tr(), false, () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              });
            }
            if (state is FailureLoginWithPasscode) {
              CustomWidgets.showMessageAlertWithF(
                  context, 'login-error'.tr(), false, () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              });
            }
          },
          builder: (context, state) {
            if (state is LoadingCheckUsePincode) {
              const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is SuccessCheckUsePincode) {
              checkPinCode(state.status);
            }
            return (isVisible)
                ? Column(
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
                            TapPasscode(
                                true, '1', OperationPin.number, stateTheme),
                            TapPasscode(
                                true, '2', OperationPin.number, stateTheme),
                            TapPasscode(
                                true, '3', OperationPin.number, stateTheme),
                            TapPasscode(
                                true, '4', OperationPin.number, stateTheme),
                            TapPasscode(
                                true, '5', OperationPin.number, stateTheme),
                            TapPasscode(
                                true, '6', OperationPin.number, stateTheme),
                            TapPasscode(
                                true, '7', OperationPin.number, stateTheme),
                            TapPasscode(
                                true, '8', OperationPin.number, stateTheme),
                            TapPasscode(
                                true, '9', OperationPin.number, stateTheme),
                            TapPasscode(false, 'Cancel', OperationPin.cancel,
                                stateTheme,
                                icon: const Icon(Icons.cancel)),
                            TapPasscode(
                                true, '0', OperationPin.number, stateTheme),
                            TapPasscode(false, 'Backspace',
                                OperationPin.backspace, stateTheme,
                                icon: const Icon(Icons.backspace_outlined)),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator.adaptive());
          },
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
