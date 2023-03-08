import 'package:flutter/material.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/widget/num_pad.dart';
import '../../../../main.dart';
import '../../../router/app_router.dart';

class LockView extends StatefulWidget {
  const LockView({super.key});

  @override
  State<LockView> createState() => _LockViewState();
}

class _LockViewState extends State<LockView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Password',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _controller,
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25.0),
            ),
            const SizedBox(height: 10.0),
            NumPad(
              controller: _controller,
              delete: () {
                _controller.text = _controller.text.substring(
                  0,
                  _controller.text.length - 1,
                );
              },
              onSubmit: () {
                String? lockPass = globalSharedPrefs!.getString(lockScreenKey);
                if (lockPass! == _controller.text) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRouterNames.bottomNavLayout,
                  );
                } else {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      content: const Text('Incorrect password'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}