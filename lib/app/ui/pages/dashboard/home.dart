import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/home_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/dashboard/dashboard.dart';
import 'package:trackhub_home_health/app/ui/pages/history/history.dart';
import 'package:trackhub_home_health/app/ui/pages/notification/notifications.dart';
import 'package:trackhub_home_health/app/ui/pages/profile/profile.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';

import '../../theme/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: PersistentTabView(
        context,
        controller: BaseController.persistentController,
        bottomScreenMargin: 0,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        navBarHeight: DeviceUtils.getScaledHeight(context, scale: 0.09),
        backgroundColor: AppColors.whiteColor,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 500),
        ),
        navBarStyle:
        NavBarStyle.style2, // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [const Dashboard(), const History(), const Notifications(), Profile()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_filled, size: 25),
          activeColorPrimary: AppColors.appColor0,
          inactiveColorPrimary: AppColors.color12),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.watch_later_rounded, size: 25),
        activeColorPrimary: AppColors.appColor0,
        inactiveColorPrimary: AppColors.color12,
      ),
      PersistentBottomNavBarItem(
        onPressed: (_) {
          BaseController.persistentController.jumpToTab(2);
        },
        icon: Badge(
            showBadge: true,
            badgeColor: Colors.transparent,
            elevation: 0,
            badgeContent: Container(
              width: 15,
              height: 15,
              child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.appColor0),
                  )),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
            child: const Icon(Icons.notifications_rounded, size: 25)),
        activeColorPrimary: AppColors.appColor0,
        inactiveColorPrimary: AppColors.color12,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings, size: 25),
        activeColorPrimary: AppColors.appColor0,
        inactiveColorPrimary: AppColors.color12,
      ),
    ];
  }
}
