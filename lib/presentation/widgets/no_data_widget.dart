import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;

    return Center(
      child: Container(
        decoration: (stateTheme == Brightness.light)
            ? backgroundThemeLight
            : backgroundThemeDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 21 / 9,
              child: Image.asset(
                (stateTheme == Brightness.light)
                    ? noDataImage
                    : noDataImageLight,
                opacity: const AlwaysStoppedAnimation(0.6),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 20,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'no-data'.tr(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
