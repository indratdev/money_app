import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:money_app/data/banner/ad_helper.dart';

class WidgetBanner extends StatefulWidget {
  const WidgetBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<WidgetBanner> createState() => _WidgetBannerState();
}

class _WidgetBannerState extends State<WidgetBanner> {
  AdRequest? adRequest;
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  @override
  void initState() {
    super.initState();

    // String bannerId = Platform.isAndroid
    //     ? "ca-app-pub-3940256099942544/6300978111"
    //     : "ca-app-pub-3940256099942544/2934735716";

    adRequest = AdRequest(nonPersonalizedAds: false);

    BannerAdListener bannerAdListener = BannerAdListener(
      onAdClosed: (ad) {
        bannerAd!.load();
      },
      onAdFailedToLoad: (ad, error) {
        bannerAd!.load();
      },
    );

    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId, //bannerId,
      listener: bannerAdListener,
      request: adRequest!,
    );

    bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 60,
        child: AdWidget(
          ad: bannerAd!,
        ),
      ),
    );
  }
}
