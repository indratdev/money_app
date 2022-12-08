import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../data/pin_manager.dart';

class StatusPadsIcons extends StatelessWidget {
  const StatusPadsIcons({
    Key? key,
    required this.pm,
  }) : super(key: key);

  final PinManager pm;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'enter-pincode'.tr(),
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
                children: <Widget>[
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
    );
  }
}
