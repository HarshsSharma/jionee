import 'package:flutter/material.dart';

import '../../../router/tab_navigator.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, TabNavigatorRoutes.page2),
          child: const Text('Navigate to page2'),
        ),
      ),
    );
  }
}
