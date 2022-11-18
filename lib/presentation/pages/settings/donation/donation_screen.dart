import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/constants.dart';

class DonationScreen extends StatelessWidget {
  DonationScreen({super.key});

  final Uri _url = Uri.parse(urlSaweria);

  Future<void> _launchInWebViewOrVC() async {
    if (!await launchUrl(
      _url,
      mode: LaunchMode.platformDefault,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('donation'.tr())),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 5,
                foregroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/donation.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SB_Height30,
              Text('donation-description'.tr(namedArgs: {'appName': appName}),
                  textAlign: TextAlign.center),
              SB_Height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DonationButton(context, 'donation-saweria'.tr(),
                      orangeSaweria, _launchInWebViewOrVC),
                  // DonationButton(context, 'donation-paypal'.tr(), bluePaypal,
                  //     _launchInWebViewOrVC,
                  //     textColor: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox DonationButton(BuildContext context, String label, Color colorButton,
      Function()? onpress,
      {Color textColor = Colors.black}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton,
        ),
        onPressed: onpress,
        child: Text(
          label,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
