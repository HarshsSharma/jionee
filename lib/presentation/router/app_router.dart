import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants/constants.dart';
import '../../di.dart';
import '../../main.dart';
import '../modules/bottom_nav_layout/bottom_nav_layot_view.dart';
import '../modules/bottom_nav_layout/evaluation/view_model/evaluation_view_model.dart';
import '../modules/bottom_nav_layout/search/view_model/movies_view_model.dart';
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
            : _bottomNavPageRoute();
      case AppRouterNames.bottomNavLayout:
        return _bottomNavPageRoute();
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

  MaterialPageRoute _bottomNavPageRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => sl<TimeOffViewModel>(),
              lazy: true,
            ),
            ChangeNotifierProvider(
              create: (_) => sl<MoviesViewModel>(),
              lazy: true,
            ),
            ChangeNotifierProvider(
              create: (_) => EvaluationsViewModel(),
              lazy: true,
            ),
          ],
          child: const BottomNavLayoutView(),
        );
      },
    );
  }
}
