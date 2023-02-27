import 'package:flutter/material.dart';

import '../../constants/enums/tab_item.dart';
import '../modules/bottom_nav_layout/category/category_view.dart';
import '../modules/bottom_nav_layout/profile/views/profile_view.dart';
import '../modules/bottom_nav_layout/time_off/views/add_time_off_request_view.dart';
import '../modules/bottom_nav_layout/time_off/views/time_off_view.dart';
import '../modules/bottom_nav_layout/search/search_view.dart';
import '../modules/page_2.dart';
import '../modules/bottom_nav_layout/time_off/views/time_off_item_details_view.dart';
import '../modules/page_three.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String itemDetails = '/ItemDetails';
  static const String page2 = '/page2';
  static const String page3 = '/page3';
  static const String timeOffItemDetails = '/Time-Off-Item-Details';
  static const String addTimeOffRequest = '/Add-Time-Off-Item-Requests';
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (tabItem == TabItem.home) {
      child = const TimeOff();
    } else if (tabItem == TabItem.search) {
      child = const SearchView();
    } else if (tabItem == TabItem.category) {
      child = const CategoryView();
    } else if (tabItem == TabItem.profile) {
      child = const HomeView();
    }
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case TabNavigatorRoutes.root:
            return MaterialPageRoute(
              builder: (_) => child!,
            );
          case TabNavigatorRoutes.page2:
            return MaterialPageRoute(
              builder: (_) => const PageTwo(),
            );
          case TabNavigatorRoutes.page3:
            return MaterialPageRoute(
              builder: (_) => const PageThree(),
            );
          case TabNavigatorRoutes.timeOffItemDetails:
            return MaterialPageRoute(
              builder: (_) => const TimeOffItemDetails(),
            );
          case TabNavigatorRoutes.addTimeOffRequest:
            return MaterialPageRoute(
              builder: (_) => const AddTimeOffRequestView(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: Text('Unknown route'),
                ),
              ),
            );
        }
      },
    );
  }
}
