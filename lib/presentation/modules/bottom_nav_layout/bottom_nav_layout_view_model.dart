import 'package:flutter/material.dart';

import '../../../constants/enums/tab_item.dart';
import 'bottom_nav_model.dart';

class BottomNavLayoutViewModel with ChangeNotifier {
  int currentIndex = 0;
  TabItem currentTap = TabItem.home;
  List<BottomNavModel> bottomData = [
    BottomNavModel(
      tabItem: TabItem.home,
      icon: Icons.calendar_month,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    BottomNavModel(
      tabItem: TabItem.search,
      icon: Icons.search,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    BottomNavModel(
      tabItem: TabItem.category,
      icon: Icons.category,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    BottomNavModel(
      tabItem: TabItem.profile,
      icon: Icons.person,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  ];

  GlobalKey<NavigatorState> getNavigatorKey(TabItem tabItem) {
    return bottomData
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
