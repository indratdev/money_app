// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:money_app/config/routes/app_routes.dart';
// import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';
// import 'package:money_app/presentation/pages/settings/pin/pin_confirmation_screen.dart';

// import '../../../../data/constants.dart';
// import '../../../../data/pin_manager.dart';

// class PinChangeScreen extends StatelessWidget {
//   PinChangeScreen({super.key});

//   PinManager pm = PinManager();
//   List<String> _tempPasscode = ['', '', '', '', '', ''];
//   List<int> _valuePasscode = [];
//   bool _passcodeAlreadyFulfilled = false;

//   @override
//   Widget build(BuildContext context) {
//     print(_tempPasscode);
//     // func confirmation next page
//     nextPageConfirmation() {
//       if (_passcodeAlreadyFulfilled == true) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 PinConfirmationScreen(valuePasscodeBefore: _valuePasscode),

//             // PinConfirmationScreen(),
//           ),
//         );
//       }
//     }

//     TapPasscode(bool isNumber, String label, OperationPin operationPin,
//         {Icon icon = const Icon(Icons.circle)}) {
//       return InkWell(
//         onTap: () {
//           if (operationPin == OperationPin.number) {
//             // pm.changePasscode(int.parse(label));
//             // BlocProvider.of<PinBloc>(context)
//             //     .add(ChangePasscodeEvent(value: int.parse(label)));
//             context
//                 .read<PinBloc>()
//                 .add(ChangePasscodeEvent(value: int.parse(label)));

//             // setState(() {});
//           } else if (operationPin == OperationPin.cancel) {
//             // pm.removeDigitPasscode();
//             context.read<PinBloc>().add(RemoveDigitPasscodeEvent());
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

//     return WillPopScope(
//       onWillPop: () async {
//         print("jalan...");
//         pm.setBasic = true;

//         // _passcodeAlreadyFulfilled = false;
//         Navigator.pop(context);
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'choose-pin'.tr(),
//           ),
//         ),
//         body: BlocBuilder<PinBloc, PinState>(
//           builder: (context, state) {
//             print(">> state is : $state ");
//             if (state is SuccessChangePasscode) {
//               _tempPasscode =
//                   state.result[PinString.tempPasscodeValue.toString()];
//               _valuePasscode =
//                   state.result[PinString.valuePasscodeValue.toString()];
//               _passcodeAlreadyFulfilled =
//                   state.result[PinString.passcodeAlreadyFulfilled.toString()];
//               Future.delayed(
//                   const Duration(seconds: 1), () => nextPageConfirmation());
//             }
//             if (state is SuccessRemoveDigitPasscode) {
//               _tempPasscode =
//                   state.result[PinString.tempPasscodeValue.toString()];
//               _valuePasscode =
//                   state.result[PinString.valuePasscodeValue.toString()];
//               _passcodeAlreadyFulfilled =
//                   state.result[PinString.passcodeAlreadyFulfilled.toString()];
//             }
//             return Column(
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   height: MediaQuery.of(context).size.height / 6,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 2.3,
//                         child: FittedBox(
//                           fit: BoxFit.contain,
//                           child: Text(
//                             'enter-pincode'.tr(),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 2,
//                         child: FittedBox(
//                           fit: BoxFit.contain,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children:
//                                 // _buildCircles(),
//                                 <Widget>[
//                               (_tempPasscode[0] == '')
//                                   ? const Icon(Icons.circle_outlined)
//                                   : const Icon(Icons.circle_rounded),
//                               (_tempPasscode[1] == '')
//                                   ? const Icon(Icons.circle_outlined)
//                                   : const Icon(Icons.circle_rounded),
//                               (_tempPasscode[2] == '')
//                                   ? const Icon(Icons.circle_outlined)
//                                   : const Icon(Icons.circle_rounded),
//                               (_tempPasscode[3] == '')
//                                   ? const Icon(Icons.circle_outlined)
//                                   : const Icon(Icons.circle_rounded),
//                               (_tempPasscode[4] == '')
//                                   ? const Icon(Icons.circle_outlined)
//                                   : const Icon(Icons.circle_rounded),
//                               (_tempPasscode[5] == '')
//                                   ? const Icon(Icons.circle_outlined)
//                                   : const Icon(Icons.circle_rounded),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: GridView.count(
//                     shrinkWrap: true,
//                     primary: false,
//                     padding: const EdgeInsets.all(20),
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     crossAxisCount: 3,
//                     children: <Widget>[
//                       TapPasscode(true, '1', OperationPin.number),
//                       TapPasscode(true, '2', OperationPin.number),
//                       TapPasscode(true, '3', OperationPin.number),
//                       TapPasscode(true, '4', OperationPin.number),
//                       TapPasscode(true, '5', OperationPin.number),
//                       TapPasscode(true, '6', OperationPin.number),
//                       TapPasscode(true, '7', OperationPin.number),
//                       TapPasscode(true, '8', OperationPin.number),
//                       TapPasscode(true, '9', OperationPin.number),
//                       TapPasscode(false, 'More', OperationPin.more,
//                           icon: const Icon(Icons.more_horiz_sharp)),
//                       TapPasscode(true, '0', OperationPin.number),
//                       TapPasscode(false, 'Cancel', OperationPin.cancel,
//                           icon: const Icon(Icons.backspace_outlined)),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
