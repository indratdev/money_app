import 'package:flutter/material.dart';

class CustomWidgets {
  static showLoadingWidget() {
    return Center(child: Text("Memuat..."));
  }

  static showConfirmationDelete(
      BuildContext context, String content, void Function()? voidCallback) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal"),
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
          title: const Text("Status"),
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

static showNoDataWidget(){
  Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 21 / 9,
                                      child: Image.asset(
                                        'assets/images/nodata.png',
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Tidak ada data"),
                                  ],
                                ),
                              )
}


// <a href="https://www.flaticon.com/free-icons/empty" title="empty icons">Empty icons created by Freepik - Flaticon</a>