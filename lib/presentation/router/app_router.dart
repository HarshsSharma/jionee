import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants/constants.dart';
import '../../di.dart';
import '../../main.dart';
import '../modules/bottom_nav_layout/bottom_nav_layot_view.dart';
import '../modules/bottom_nav_layout/time_off/view_model/time_off_view_model.dart';
import '../modules/lock_password/views/lock_view.dart';

class AppRouterNames {
  static const String bottomNavLayout = '/bottom-nav-layout';
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        String? lockPass = globalSharedPrefs!.getString(lockScreenKey);
        return lockPass != null
            ? MaterialPageRoute(
                builder: (context) => const LockView(),
              )
            : MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                  create: (_) => sl<TimeOffViewModel>(),
                  lazy: true,
                  child: const BottomNavLayoutView(),
                ),
              );
      case AppRouterNames.bottomNavLayout:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<TimeOffViewModel>(),
            lazy: true,
            child: const BottomNavLayoutView(),
          ),
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
  }
}
