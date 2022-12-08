import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AttentionWidget extends StatelessWidget {
  const AttentionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          text: 'pin-information'.tr(),
          style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 18),
        ),
      ),
    );
  }
}
