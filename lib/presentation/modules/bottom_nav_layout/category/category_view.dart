import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../../common/network/network_info.dart';
import '../../../../di.dart';
import '../../no_internet/view/no_internet_view.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<ConnectivityResult>(
        future: sl<NetworkInfo>().isConnected,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Center(
              child: snapshot.data == ConnectivityResult.mobile ||
                      snapshot.data == ConnectivityResult.wifi
                  ? const SizedBox(
                      child: Text('There is a connexion'),
                    )
                  : NoInternetView(
                      retryCallback: () {},
                    ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
