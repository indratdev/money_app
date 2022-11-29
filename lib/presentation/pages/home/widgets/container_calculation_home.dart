import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/presentation/pages/home/widgets/calculation_section.dart';

import '../../../../data/constants.dart';
import '../../../../domain/entities/calculationE.dart';

class ContainerCalculationHome extends StatelessWidget {
  const ContainerCalculationHome({
    Key? key,
    required this.stateTheme,
    required this.widhtContainer,
    required this.listCalculation,
  }) : super(key: key);

  final Brightness stateTheme;
  final double widhtContainer;
  final List<CalculationE>? listCalculation;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: calculationDecor,
      decoration: (stateTheme == Brightness.light)
          ? calculationDecor
          : calculationDecorDark,
      height: MediaQuery.of(context).size.height / 10,
      margin: const EdgeInsets.only(top: 5, bottom: 15, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // sizebox pengeluaran
          CalculationSection(
            widhtContainer: widhtContainer,
            listCalculation: listCalculation,
            labelName: 'expense'.tr(),
            category: listCalculation?[0].expense ?? 0.0,
            textColor: redCalculation,
          ),
          // container penerimaan
          CalculationSection(
            widhtContainer: widhtContainer,
            listCalculation: listCalculation,
            labelName: 'income'.tr(),
            category: listCalculation?[0].income ?? 0.0,
            textColor: greenCalculation,
          ),

          // selisih
          CalculationSection(
            widhtContainer: widhtContainer,
            listCalculation: listCalculation,
            labelName: 'deviation'.tr(),
            category: listCalculation?[0].profit ?? 0.0,
            textColor:
                (stateTheme == Brightness.light) ? blackDefault : lightWhite,
          ),
          // Container(
        ],
      ),
    );
  }
}
