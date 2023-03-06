// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:jionee/common/enums/tab_item.dart';

class BottomNavModel {
  final TabItem tabItem;
  final IconData icon;
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget mainScreen;
  const BottomNavModel({
    required this.tabItem,
    required this.icon,
    required this.navigatorKey,
    required this.mainScreen,
  });
}

class BottomNavRoutModel {
  final List<BottomNavModel> tabs;
  final Map<String, Widget Function(BuildContext)> routes;
  const BottomNavRoutModel({
    required this.tabs,
    required this.routes,
  });
}
