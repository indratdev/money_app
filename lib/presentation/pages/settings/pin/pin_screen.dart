import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_app/config/routes/app_routes.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title-pin'.tr()),
      ),
      body: Center(
        child: Column(children: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.settPinChange);
              },
              child: Text('set-pin'.tr()))
        ]),
      ),
    );
  }
}
