import 'package:flutter/material.dart';
import 'package:jionee/common/enums/tab_item.dart';
import 'package:provider/provider.dart';

import '../../router/tab_navigator.dart';
import 'bottom_nav_layout_view_model.dart';

class BottomNavLayoutView extends StatefulWidget {
  const BottomNavLayoutView({super.key});

  @override
  State<BottomNavLayoutView> createState() => _BottomNavLayoutViewState();
}

class _BottomNavLayoutViewState extends State<BottomNavLayoutView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavLayoutViewModel>(context);
    return WillPopScope(
      onWillPop: () async => !await provider
          .getNavigatorKey(provider.currentTap)
          .currentState!
          .maybePop(),
      child: Scaffold(
        body: Stack(
          children: provider.bottomData.tabs
              .map((e) => _buildOffstageNavigator(e.tabItem, e.mainScreen))
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: (index) {
            provider.changeCurrentIndex(
                provider.bottomData.tabs[index].tabItem, index);
          },
          items: provider.bottomData.tabs
              .map(
                (e) => BottomNavigationBarItem(
                  label: '',
                  icon: Icon(e.icon),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem, Widget child) {
    final provider = Provider.of<BottomNavLayoutViewModel>(context);
    return Offstage(
      offstage: provider.currentTap != tabItem,
      child: TabNavigator(
        navigatorKey: provider.getNavigatorKey(tabItem),
        mainView: child,
        routes: provider.bottomData.routes,
      ),
    );
  }
}
