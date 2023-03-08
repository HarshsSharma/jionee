import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/enums/model_theme.dart';
import '../../../../../common/styles/theme_mode_logic.dart';

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
            ],
          );
        },
      ),
    );
  }
}
