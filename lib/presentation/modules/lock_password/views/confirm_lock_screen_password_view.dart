import 'package:flutter/material.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/widget/input_text_form_field.dart';
import '../../../../main.dart';

class ConfirmLockScreenPasswordView extends StatefulWidget {
  const ConfirmLockScreenPasswordView({super.key});

  @override
  State<ConfirmLockScreenPasswordView> createState() =>
      _ConfirmLockScreenPasswordViewState();
}


class _ConfirmLockScreenPasswordViewState
    extends State<ConfirmLockScreenPasswordView> {
  final TextEditingController _controller = TextEditingController();
  final _globaKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _whenValid() {
    if (_globaKey.currentState!.validate()) {
      globalSharedPrefs!
          .setString(lockScreenKey, _controller.text)
          .whenComplete(() => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    String passText = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm password'),
        actions: [
          IconButton(
            onPressed: _whenValid,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Form(
        key: _globaKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTextFormFieldWidget(
                  maxLines: 1,
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  obscureText: true,
                  onSaved: (_) => _whenValid(),
                  labelText: 'Confirm Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please, enter your password';
                    } else if (value.length < 4) {
                      return 'Password lenght must be greater than 3';
                    } else if (value != passText) {
                      return 'Passwords is incorrect';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
