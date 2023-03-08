import 'package:flutter/material.dart';

import '../../../../common/widget/input_text_form_field.dart';
import '../../../router/tab_navigator.dart';

class SetLockScreenPasswordView extends StatefulWidget {
  const SetLockScreenPasswordView({super.key});

  @override
  State<SetLockScreenPasswordView> createState() =>
      _SetLockScreenPasswordViewState();
}

class _SetLockScreenPasswordViewState extends State<SetLockScreenPasswordView> {
  final TextEditingController _controller = TextEditingController();
  final _globaKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _whenValid() {
    if (_globaKey.currentState!.validate()) {
      Navigator.popAndPushNamed(
        context,
        TabNavigatorRoutes.confirmLockScreenPass,
        arguments: _controller.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter password'),
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
                  labelText: 'Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please, enter your password';
                    } else if (value.length < 4) {
                      return 'Password lenght must be greater than 3';
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
