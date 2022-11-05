import 'package:flutter/material.dart';

import '../../../../data/constants.dart';
import '../../../../domain/entities/calculationE.dart';

class CalculationSection extends StatelessWidget {
  const CalculationSection({
    super.key,
    required this.widhtContainer,
    required this.listCalculation,
    required this.labelName,
    required this.category,
    required this.textColor,
  });

  final double widhtContainer;
  final List<CalculationE>? listCalculation;
  final String labelName;
  final double? category;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 5,
      width: widhtContainer,
      // color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                // "Pengeluaran",
                labelName,
                softWrap: true,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "${formatterThousand.format(double.tryParse(category.toString()))}",
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
