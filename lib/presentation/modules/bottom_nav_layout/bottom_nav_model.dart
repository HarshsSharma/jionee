import 'package:flutter/material.dart';

import '../../../constants/enums/tab_item.dart';

class BottomNavModel {
  final TabItem tabItem;
  final IconData icon;
  final GlobalKey<NavigatorState> navigatorKey;
  const BottomNavModel({
    required this.tabItem,
    required this.icon,
    required this.navigatorKey,
  });
}
