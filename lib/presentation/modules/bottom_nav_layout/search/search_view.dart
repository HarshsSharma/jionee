import 'package:flutter/material.dart';

import '../../../router/tab_navigator.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, TabNavigatorRoutes.page3),
          child: const Text('Navigate to page3'),
        ),
      ),
    );
  }
}
