import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../config/menus/menus.dart';
import '../data/constants.dart';

class MoneyappScreen extends StatelessWidget {
  MoneyappScreen({Key? key}) : super(key: key);
  final menu = Menus();

  @override
  Widget build(BuildContext context) {
    int _index = 0;
    final stateTheme = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        body: menu.bottomScreenMenu().elementAt(_index),
        bottomNavigationBar: PersistentTabView(
          context,
          screens: menu.bottomScreenMenu(),
          items: menu.navBarsItems(context, stateTheme),
          confineInSafeArea: true,
          backgroundColor:
              (stateTheme == Brightness.light) ? lightMildWaters : blackDefault,

          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.

          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
            adjustScreenBottomPaddingOnCurve: true,
          ),
          popAllScreensOnTapOfSelectedTab: true,

          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),

          navBarStyle: NavBarStyle
              .style16, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}
