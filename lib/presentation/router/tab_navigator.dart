import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String itemDetails = '/ItemDetails';
  static const String timeOffItemDetails = '/Time-Off-Item-Details';
  static const String addTimeOffRequest = '/Add-Time-Off-Item-Requests';
  static const String setLockScreenPass = '/Set-Lock-Screen-Password';
  static const String confirmLockScreenPass = '/Confirm-Lock-Screen-Password';
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget mainView;
  final Map<String, Widget Function(BuildContext)> routes;
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.mainView,
    required this.routes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        final String? name = routeSettings.name;
        final WidgetBuilder? pageContentBuilder = routes[name];
        if (name == TabNavigatorRoutes.root) {
          return MaterialPageRoute(
            builder: (_) => mainView,
          );
        } else if (pageContentBuilder != null) {
          final Route<dynamic> route = MaterialPageRoute(
            settings: routeSettings,
            builder: pageContentBuilder,
          );

          return route;
        } else {
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
