import 'package:flutter/material.dart';
import 'package:jionee/common/extensions/media_query.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/styles/colors.dart';
import '../../../../common/widget/num_pad.dart';
import '../../../../main.dart';
import '../../../router/app_router.dart';

class LockView extends StatefulWidget {
  const LockView({super.key});

  @override
  State<LockView> createState() => _LockViewState();
}

class _LockViewState extends State<LockView> {
  final String _title = 'Enter Password';
  final TextEditingController _controller = TextEditingController();
  String? lockPass;
  @override
  void initState() {
    lockPass = globalSharedPrefs!.getString(lockScreenKey);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          // first part of this condition check if this
          // screen for tablet or ipad or a screen for divice
          // bigger than the mobile phone
          return (orientation == Orientation.landscape &&
                      context.shortestSide >= 600) ||
                  //
                  (orientation == Orientation.portrait)
              ? _buildVerticalLayout()
              : _buildHorizontalLayout();
        },
      ),
    );
  }

  Center _buildHorizontalLayout() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _controller,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30.0),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: _textFiledBorder(),
                      enabledBorder: _textFiledBorder(),
                      disabledBorder: _textFiledBorder(),
                      focusedBorder: _textFiledBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: NumPad(
              controller: _controller,
              delete: _delete,
              onSubmit: _onSubmit,
            ),
          ),
        ],
      ),
    );
  }

  Center _buildVerticalLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _controller,
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30.0),
              readOnly: true,
              decoration: InputDecoration(
                border: _textFiledBorder(),
                enabledBorder: _textFiledBorder(),
                disabledBorder: _textFiledBorder(),
                focusedBorder: _textFiledBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          NumPad(
            controller: _controller,
            delete: _delete,
            onSubmit: _onSubmit,
          ),
        ],
      ),
    );
  }

  UnderlineInputBorder _textFiledBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.brightness == Brightness.dark
            ? AppColors.darkModePrimaryColor
            : AppColors.primaryColor,
      ),
    );
  }

  void _delete() {
    if (_controller.text.isNotEmpty) {
      _controller.text = _controller.text.substring(
        0,
        _controller.text.length - 1,
      );
    }
  }

  void _onSubmit() {
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
          content: Text(
            'Incorrect password',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
