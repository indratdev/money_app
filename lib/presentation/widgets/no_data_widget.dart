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
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.width / 14,
            // color: Colors.red,
            child: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "Tidak ada data",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
