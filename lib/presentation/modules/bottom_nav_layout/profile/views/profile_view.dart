import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/constants.dart';
import '../../../../../common/enums/model_theme.dart';
import '../../../../../common/styles/theme_mode_logic.dart';
import '../../../../../common/widget/dialog.dart';
import '../../../../../main.dart';
import '../../../../router/tab_navigator.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ModelTheme>(
        builder: (_, themeNotifier, __) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  'Change Theme Mode',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: ThemeMode.values
                              .map(
                                (e) => RadioListTile<ThemeMode>(
                                  title: Text(
                                    e == ThemeMode.system
                                        ? 'Default'
                                        : e == ThemeMode.dark
                                            ? 'Dark'
                                            : 'Light',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  value: e,
                                  groupValue: themeNotifier.themeMode,
                                  onChanged: (value) {
                                    themeNotifier
                                        .changeCurrentTheme(value!.name);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Font Size',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: TextScaleFactorValue.values
                              .map(
                                (e) => RadioListTile<double>(
                                  title: Text(
                                    e.type,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  value: e.scaleValue,
                                  groupValue: themeNotifier.textScaleFactor,
                                  onChanged: (value) {
                                    themeNotifier.changeTextScaleFactor(value!);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                onTap: () {
                  String? lockPass =
                      globalSharedPrefs!.getString(lockScreenKey);
                  if (lockPass != null) {
                    _showDialog(lockPass);
                  } else {
                    Navigator.pushNamed(
                      context,
                      TabNavigatorRoutes.setLockScreenPass,
                    );
                  }
                },
                title: Text(
                  'Lock Screen',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDialog(String lockPass) {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogBuilder(
        title: 'Lock password',
        message: 'You have already set your lock',
        actions: [
          DialogButtonData(
            title: 'Update',
            onTap: () {
              Navigator.pop(ctx);
              showDialog(
                context: context,
                builder: (ctx) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Enter password',
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onSubmitted: (value) {
                            if (value == lockPass) {
                              Navigator.pop(ctx);
                              Navigator.pushNamed(
                                context,
                                TabNavigatorRoutes.setLockScreenPass,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          DialogButtonData(
            title: 'Delete',
            onTap: () {
              Navigator.pop(ctx);
              showDialog(
                context: context,
                builder: (ctx) => CustomDialogBuilder(
                  title: 'Are you sure?',
                  message: 'You will remove lock screen mode',
                  actions: [
                    DialogButtonData(
                      title: 'Yes',
                      onTap: () => globalSharedPrefs!
                          .remove(lockScreenKey)
                          .whenComplete(() => Navigator.pop(ctx)),
                    ),
                    DialogButtonData(
                      title: 'No',
                      onTap: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
