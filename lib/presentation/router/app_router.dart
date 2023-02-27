import 'package:flutter/material.dart';

import '../modules/bottom_nav_layout/bottom_nav_layot_view.dart';

class AppRouterNames {
  // static const String itemDetailsRoute = '/item-details';
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const BottomNavLayoutView());
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
