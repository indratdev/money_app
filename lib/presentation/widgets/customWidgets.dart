import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomWidgets {
  static showLoadingWidget() {
    return Center(child: Text('loading'.tr()));
  }

  static showConfirmationDelete(
      BuildContext context, String content, void Function()? voidCallback) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('confirmation'.tr()),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: voidCallback,
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static showMessageAlertBasic(BuildContext context, String content) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('status'.tr()),
          content: Text(content),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"))
          ],
        );
      },
    );
  }
}




// <a href="https://www.flaticon.com/free-icons/empty" title="empty icons">Empty icons created by Freepik - Flaticon</a>