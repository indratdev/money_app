// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:money_app/config/menus/menus.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// import '../../data/constants.dart';

// class CustomBottomNav extends StatefulWidget {
//   const CustomBottomNav({
//     Key? key,
//     required this.menu,
//     required this.stateTheme,
//   }) : super(key: key);

//   final Menus menu;
//   final Brightness stateTheme;

//   @override
//   State<CustomBottomNav> createState() => _CustomBottomNavState();
// }

// class _CustomBottomNavState extends State<CustomBottomNav> {
//   AdRequest? adRequest;
//   BannerAd? bannerAd;
//   InterstitialAd? interstitialAd;
//   RewardedAd? rewardedAd;

//   @override
//   void initState() {
//     super.initState();

//     String bannerId = Platform.isAndroid
//         ? "ca-app-pub-3940256099942544/6300978111"
//         : "ca-app-pub-3940256099942544/2934735716";

//     adRequest = AdRequest(nonPersonalizedAds: false);

//     BannerAdListener bannerAdListener = BannerAdListener(
//       onAdClosed: (ad) {
//         bannerAd!.load();
//       },
//       onAdFailedToLoad: (ad, error) {
//         bannerAd!.load();
//       },
//     );

//     bannerAd = BannerAd(
//       size: AdSize.banner,
//       adUnitId: bannerId,
//       listener: bannerAdListener,
//       request: adRequest!,
//     );

//     bannerAd!.load();
//   }

//   @override
//   void dispose() {
//     bannerAd!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 56,
//           child: PersistentTabView(
//             context,
//             screens: widget.menu.bottomScreenMenu(),
//             items: widget.menu.navBarsItems(context, widget.stateTheme),
//             confineInSafeArea: true,
//             backgroundColor: (widget.stateTheme == Brightness.light)
//                 ? lightMildWaters
//                 : blackDefault,

//             handleAndroidBackButtonPress: true, // Default is true.
//             resizeToAvoidBottomInset:
//                 true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//             stateManagement: true, // Default is true.

//             hideNavigationBarWhenKeyboardShows:
//                 true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//             decoration: NavBarDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               colorBehindNavBar: Colors.white,
//               adjustScreenBottomPaddingOnCurve: true,
//             ),
//             popAllScreensOnTapOfSelectedTab: true,

//             popActionScreens: PopActionScreensType.all,
//             itemAnimationProperties: const ItemAnimationProperties(
//               // Navigation Bar's items animation properties.
//               duration: Duration(milliseconds: 200),
//               curve: Curves.ease,
//             ),
//             screenTransitionAnimation: const ScreenTransitionAnimation(
//               // Screen transition animation on change of selected tab.
//               animateTabTransition: true,
//               curve: Curves.ease,
//               duration: Duration(milliseconds: 200),
//             ),

//             navBarStyle: NavBarStyle
//                 .style16, // Choose the nav bar style with this property.
//           ),
//         ),
//         SizedBox(
//           height: 40,
//           child: AdWidget(
//             ad: bannerAd!,
//           ),
//         ),
//       ],
//     );
//   }
// }
