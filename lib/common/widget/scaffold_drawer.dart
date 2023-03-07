import 'package:flutter/material.dart';

import 'app_drawer.dart';

class ScaffoldDrawer extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  const ScaffoldDrawer({
    Key? key,
    this.appBar,
    this.body,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      endDrawer: const AppDrawer(),
    );
  }
}
