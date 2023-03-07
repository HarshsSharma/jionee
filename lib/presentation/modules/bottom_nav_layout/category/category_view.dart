import 'package:flutter/material.dart';

import '../../no_internet/view/no_internet_view.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: NoInternetView(
          retryCallback: () {},
        ),
      ),
    );
  }
}
