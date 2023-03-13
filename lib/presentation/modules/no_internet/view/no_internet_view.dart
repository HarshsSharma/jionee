import 'package:flutter/material.dart';

import '../../../../common/constants/typedefs.dart';


class NoInternetView extends StatelessWidget {
  final RetryCallback retryCallback;
  final String title;
  final String retryCallbackText;
  const NoInternetView({
    Key? key,
    required this.retryCallback,
    this.title = 'No Internet Connection!',
    this.retryCallbackText = 'Tap to try again',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.error,
          radius: 40.0,
          child: const Icon(
            Icons.close,
            size: 40.0,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        TextButton.icon(
          onPressed: retryCallback,
          icon: Icon(
            Icons.restart_alt,
            color: Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          label: Text(
            retryCallbackText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
