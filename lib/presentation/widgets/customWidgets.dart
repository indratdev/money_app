import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';

class CustomWidgets {
  static showLoadingWidget() {
    return Center(child: Text('loading'.tr()));
  }

  static showConfirmationDelete(
      BuildContext context, String content, void Function()? voidCallback) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 8,
                      foregroundColor: Colors.transparent,
                      child: Image.asset(warningImage),
                    ),
                    SB_Height20,
                    Text(content),
                    SB_Height20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Text('cancel'.tr(),
                              style: const TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: lightBlue),
                          onPressed: voidCallback,
                          child: const Text("OK"),
                        ),
                      ],
                    )
                    // SizedBox(
                    //     width: MediaQuery.of(context).size.width / 2,
                    //     child: ElevatedButton(
                    //         onPressed: () => Navigator.pop(context),
                    //         child: const Text("OK")))
                  ],
                ),
              ),
            ),
          );
        });
    // return showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: Text('confirmation'.tr()),
    //       content: Text(content),
    //       actions: [
    //         ElevatedButton(
    //           onPressed: () => Navigator.pop(context),
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: Colors.white,
    //           ),
    //           child: Text('cancel'.tr(),
    //               style: const TextStyle(color: Colors.black)),
    //         ),
    //         ElevatedButton(
    //           style: ElevatedButton.styleFrom(backgroundColor: lightBlue),
    //           onPressed: voidCallback,
    //           child: Text("OK"),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  static showConfirmationDelete2(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text('cancel'.tr(),
                  style: const TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: lightBlue),
              onPressed: voidCallback,
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static showMessageAlertBasic2(BuildContext context, String content) {
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

  static showMessageAlertBasic(
      BuildContext context, String content, bool isSuccess) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 8,
                      foregroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          (isSuccess) ? successImage : failedImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SB_Height20,
                    Text(content),
                    SB_Height20,
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK")))
                  ],
                ),
              ),
            ),
          );
        });
  }
}




// <a href="https://www.flaticon.com/free-icons/empty" title="empty icons">Empty icons created by Freepik - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/tick" title="tick icons">Tick icons created by Roundicons - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/cross" title="cross icons">Cross icons created by Roundicons - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/warning" title="warning icons">Warning icons created by Smashicons - Flaticon</a>