// import 'package:easy_localization/easy_localization.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// import '../../../../data/constants.dart';
// import '../chart_screen.dart';

// Container ContainerIncomeChart(
//     Brightness stateTheme, Map<String, dynamic> resultChart) {
//   return Container(
//     decoration: customCircularBox(
//       color: (stateTheme == Brightness.light)
//           ? Colors.white60
//           // : lightPurple,
//           : blackN,
//     ),
//     padding: const EdgeInsets.all(10),
//     margin: const EdgeInsets.only(left: 20, right: 20),
//     child: Column(
//       children: [
//         Text(
//           'income'.tr(),
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(
//           height: 200,
//           width: 300,

//           // color: (stateTheme == Brightness.light)
//           //     ? Colors.white60
//           //     : Colors.red,
//           child: PieChart(
//             PieChartData(
//               borderData: FlBorderData(show: true),
//               sectionsSpace: 3,
//               centerSpaceRadius: 40,
//               sections: showingSections(resultChart, 0),
//             ),
//             swapAnimationCurve: Curves.easeInOutCubic,
//             swapAnimationDuration: Duration(milliseconds: 1000),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 30),
//           height: 200,
//           width: 300,
//           decoration: customCircularBox(
//             color: (stateTheme == Brightness.light
//                 ? greenCalculation
//                 : greenDeepCalculation),
//             // : seagull),
//           ),
//           child: ShowingDetailSection(resultChart: resultChart, isOutcome: 0),
//         ),
//       ],
//     ),
//   );
// }
