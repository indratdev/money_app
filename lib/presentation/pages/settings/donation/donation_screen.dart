import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/constants.dart';

class DonationScreen extends StatelessWidget {
  DonationScreen({super.key});

  final Uri _url = Uri.parse(urlSaweria);
  // final Uri _url = Uri.parse(
  //     'https://saweria.co/widgets/qr?streamKey=4bb4f87a72b10645e7138513794e1adf');
  //https://saweria.co/indratdev

  // Uri(

  //     scheme: 'https',
  //     host: 'saweria.co/widgets/qr?streamKey=4bb4f87a72b10645e7138513794e1adf');

  // _launchMap() async {
  //   const String saweriaUrl =
  //       "https://saweria.co/widgets/qr?streamKey=4bb4f87a72b10645e7138513794e1adf";
  //   // final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

  //   if (await canLaunchUrl(Uri.parse(saweriaUrl))) {
  //     await launchUrl(Uri.parse(saweriaUrl));
  //   }
  //   // if (await canLaunch(appleMapsUrl)) {
  //   //   await launch(appleMapsUrl, forceSafariVC: false);
  //   // }
  //   else {
  //     throw "Couldn't launch URL";
  //   }
  // }

  // Future<void> _launchInWebViewOrVC(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.inAppWebView,
  //     webViewConfiguration: const WebViewConfiguration(
  //         headers: <String, String>{'my_header_key': 'my_header_value'}),
  //   )) {
  //     throw 'Could not launch $url';
  //   }
  // }

  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw 'Could not launch $_url';
  //   }
  // }

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
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('donation-description'.tr(namedArgs: {'appName': appName}),
                textAlign: TextAlign.center),
            SB_Height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DonationButton(context, 'donation-saweria'.tr(), orangeSaweria,
                    _launchInWebViewOrVC),
                DonationButton(context, 'donation-paypal'.tr(), bluePaypal,
                    _launchInWebViewOrVC,
                    textColor: Colors.white),
              ],
            ),
          ],
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
