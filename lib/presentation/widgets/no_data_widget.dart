import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 21 / 9,
            child: Image.asset(
              noDataImage,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 20,
            // color: Colors.red,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'no-data'.tr(),
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
