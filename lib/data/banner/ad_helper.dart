import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1582141259719037/5946760049';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1582141259719037~7071854042';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1582141259719037/6030235119';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1582141259719037~7071854042';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static List<String> get getTestBannerID {
    return ['7403994E28C6E50FD0222AE51CA780C9'];
  }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return '<YOUR_ANDROID_REWARDED_AD_UNIT_ID>';
  //   } else if (Platform.isIOS) {
  //     return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }
}
