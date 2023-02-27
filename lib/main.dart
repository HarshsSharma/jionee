import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'di.dart';
import 'presentation/modules/bottom_nav_layout/bottom_nav_layout_view_model.dart';
import 'presentation/modules/bottom_nav_layout/time_off/view_model/time_off_view_model.dart';
import 'presentation/router/app_router.dart';
import 'presentation/styles/themes.dart';

void main() {
  setupServiceLocator();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    required this.appRouter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavLayoutViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<TimeOffViewModel>(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
