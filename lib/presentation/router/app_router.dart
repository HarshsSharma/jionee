import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../modules/bottom_nav_layout/bottom_nav_layot_view.dart';
import '../modules/bottom_nav_layout/time_off/view_model/time_off_view_model.dart';

class AppRouterNames {
  // static const String itemDetailsRoute = '/item-details';
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
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
