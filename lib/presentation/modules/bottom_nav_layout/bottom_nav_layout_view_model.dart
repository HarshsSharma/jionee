import 'package:flutter/material.dart';
import 'package:jionee/common/enums/tab_item.dart';

import '../../router/tab_navigator.dart';
import '../lock_password/views/confirm_lock_screen_password_view.dart';
import '../lock_password/views/set_lock_screen_password_view.dart';
import 'bottom_nav_model.dart';
import 'category/category_view.dart';
import 'profile/views/profile_view.dart';
import 'search/view/search_view.dart';
import 'time_off/views/add_time_off_request_view.dart';
import 'time_off/views/time_off_item_details_view.dart';
import 'time_off/views/time_off_view.dart';

class BottomNavLayoutViewModel with ChangeNotifier {
  int currentIndex = 0;
  TabItem currentTap = TabItem.home;
  BottomNavRoutModel bottomData = BottomNavRoutModel(
    tabs: [
      BottomNavModel(
        tabItem: TabItem.home,
        icon: Icons.calendar_month,
        navigatorKey: GlobalKey<NavigatorState>(),
        mainScreen: const TimeOff(),
      ),
      BottomNavModel(
          tabItem: TabItem.search,
          icon: Icons.search,
          navigatorKey: GlobalKey<NavigatorState>(),
          mainScreen: const SearchView()),
      BottomNavModel(
        tabItem: TabItem.category,
        icon: Icons.category,
        navigatorKey: GlobalKey<NavigatorState>(),
        mainScreen: const CategoryView(),
      ),
      BottomNavModel(
        tabItem: TabItem.profile,
        icon: Icons.person,
        navigatorKey: GlobalKey<NavigatorState>(),
        mainScreen: const ProfileView(),
      ),
    ],
    routes: {
      TabNavigatorRoutes.timeOffItemDetails: (context) =>
          const TimeOffItemDetails(),
      TabNavigatorRoutes.addTimeOffRequest: (context) =>
          const AddTimeOffRequestView(),
      TabNavigatorRoutes.setLockScreenPass: (context) =>
          const SetLockScreenPasswordView(),
      TabNavigatorRoutes.confirmLockScreenPass: (context) =>
          const ConfirmLockScreenPasswordView(),
    },
  );

  GlobalKey<NavigatorState> getNavigatorKey(TabItem tabItem) {
    return bottomData.tabs
        .firstWhere((element) => element.tabItem == tabItem)
        .navigatorKey;
  }

  void changeCurrentIndex(TabItem item, int index) {
    if (item == currentTap) {
      getNavigatorKey(item).currentState!.popUntil((route) => route.isFirst);
    } else {
      currentIndex = index;
      currentTap = item;
      notifyListeners();
    }
  }
}
