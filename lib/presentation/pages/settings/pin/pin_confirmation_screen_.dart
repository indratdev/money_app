// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';

// import '../../../../data/constants.dart';
// import '../../../../data/pin_manager.dart';
// import '../../../widgets/customWidgets.dart';

// class PinConfirmationScreen extends StatelessWidget {
//   // final List<int> valuePasscodeBefore;

//   PinConfirmationScreen({
//     super.key,
//     // this.valuePasscodeBefore = const [],
//   });

//   PinManager pmg = PinManager();
//   List<String> _tempPasscode = ['', '', '', '', '', ''];
//   List<int> _valuePasscode = [];

//   @override
//   Widget build(BuildContext context) {
//     // print("valuePasscodeBefore :: ${valuePasscodeBefore}");
//     // print("_tempPasscode conf : $_tempPasscode");
//     // print("_tempPasscode[0] : ${_tempPasscode[0]}");
//     changePasscode(int value) {
//       if (_valuePasscode.length < pmg.getMaxLengthPasscode) {
//         _valuePasscode.add(value);
//         _tempPasscode[_valuePasscode.length - 1] =
//             value.toString(); //update tempp
//       }

//       // passcode already 6
//       if (_valuePasscode.length == pmg.getMaxLengthPasscode) {
//         // if (pm.isValidPasscode(valuePasscodeBefore, _valuePasscode)) {
//         //   print("samaaaa");
//         // } else {
//         //   CustomWidgets.showMessageAlertBasic(
//         //       context, "Passcode Tidak Sama", false);
//         // }
//       }
//     }

//     removeDigitPasscode() {
//       if (_valuePasscode.isNotEmpty) {
//         _valuePasscode.removeLast();
//         _tempPasscode[_valuePasscode.length] = '';
//       }
//     }

//     TapPasscode(bool isNumber, String label, OperationPin operationPin,
//         {Icon icon = const Icon(Icons.circle)}) {
//       return InkWell(
//         onTap: () {
//           print(">> tapped");
//           if (operationPin == OperationPin.number) {
//             // changePasscode(int.parse(label));
//             context
//                 .read<PinBloc>()
//                 .add(ChangePasscodeConfirmationEvent(value: int.parse(label)));
//           } else if (operationPin == OperationPin.cancel) {
//             // removeDigitPasscode();
//           }
//         },
//         child: Container(
//           decoration: const BoxDecoration(
//             color: lightMildWaters,
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width / 15,
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: (isNumber) ? Text(label) : icon,
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('confirm-pincode'.tr())),
//       body: BlocConsumer<PinBloc, PinState>(
//         listener: (context, state) {
//           // if (state is SuccessChangePasscode) {
//           //   _tempPasscode =
//           //       state.result[PinString.tempPasscodeValue.toString()];
//           //   _valuePasscode =
//           //       state.result[PinString.valuePasscodeValue.toString()];
//           //   // _passcodeAlreadyFulfilled =
//           //   //     st
//           // }
//         },
//         builder: (context, state) {
//           print(">>> state : $state");
//           if (state is SuccessChangePasscodeConfirmation) {
//             _tempPasscode =
//                 state.result[PinString.tempPasscodeValue.toString()];
//             _valuePasscode =
//                 state.result[PinString.valuePasscodeValue.toString()];
//             // _passcodeAlreadyFulfilled =
//             //     state.result[PinString.passcodeAlreadyFulfilled.toString()];
//           }
//           return Column(
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 height: MediaQuery.of(context).size.height / 6,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 2.3,
//                       child: FittedBox(
//                         fit: BoxFit.contain,
//                         child: Text(
//                           'confirm-pincode'.tr(),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 2,
//                       child: FittedBox(
//                         fit: BoxFit.contain,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children:
//                               // _buildCircles(),
//                               <Widget>[
//                             // _tempPasscode[0] == '' ||
//                             (_tempPasscode[0] == '')
//                                 ? const Icon(Icons.circle_outlined)
//                                 : const Icon(Icons.circle_rounded),
//                             (_tempPasscode[1] == '')
//                                 ? const Icon(Icons.circle_outlined)
//                                 : const Icon(Icons.circle_rounded),
//                             (_tempPasscode[2] == '')
//                                 ? const Icon(Icons.circle_outlined)
//                                 : const Icon(Icons.circle_rounded),
//                             (_tempPasscode[3] == '')
//                                 ? const Icon(Icons.circle_outlined)
//                                 : const Icon(Icons.circle_rounded),
//                             (_tempPasscode[4] == '')
//                                 ? const Icon(Icons.circle_outlined)
//                                 : const Icon(Icons.circle_rounded),
//                             (_tempPasscode[5] == '')
//                                 ? const Icon(Icons.circle_outlined)
//                                 : const Icon(Icons.circle_rounded),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: GridView.count(
//                   shrinkWrap: true,
//                   primary: false,
//                   padding: const EdgeInsets.all(20),
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   crossAxisCount: 3,
//                   children: <Widget>[
//                     TapPasscode(true, '1', OperationPin.number),
//                     TapPasscode(true, '2', OperationPin.number),
//                     TapPasscode(true, '3', OperationPin.number),
//                     TapPasscode(true, '4', OperationPin.number),
//                     TapPasscode(true, '5', OperationPin.number),
//                     TapPasscode(true, '6', OperationPin.number),
//                     TapPasscode(true, '7', OperationPin.number),
//                     TapPasscode(true, '8', OperationPin.number),
//                     TapPasscode(true, '9', OperationPin.number),
//                     TapPasscode(false, 'More', OperationPin.more,
//                         icon: const Icon(Icons.more_horiz_sharp)),
//                     TapPasscode(true, '0', OperationPin.number),
//                     TapPasscode(false, 'Cancel', OperationPin.cancel,
//                         icon: const Icon(Icons.backspace_outlined)),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// enum OperationPin { number, cancel, more }
