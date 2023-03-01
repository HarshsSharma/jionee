import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../styles/theme_mode_logic.dart';

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
                          children: [
                            RadioListTile<ThemeMode>(
                              title: Text(
                                'Default',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              value: ThemeMode.system,
                              groupValue: themeNotifier.themeMode,
                              onChanged: (value) {
                                themeNotifier.changeCurrentTheme(value!.name);
                              },
                            ),
                            RadioListTile<ThemeMode>(
                              title: Text(
                                'Dark',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              value: ThemeMode.dark,
                              groupValue: themeNotifier.themeMode,
                              onChanged: (value) {
                                themeNotifier.changeCurrentTheme(value!.name);
                              },
                            ),
                            RadioListTile<ThemeMode>(
                              title: Text(
                                'Light',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              value: ThemeMode.light,
                              groupValue: themeNotifier.themeMode,
                              onChanged: (value) {
                                themeNotifier.changeCurrentTheme(value!.name);
                              },
                            ),
                          ],
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
                          children: [
                            RadioListTile<double>(
                              title: Text(
                                'Small',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              value: 0.8,
                              groupValue: themeNotifier.textScaleFactor,
                              onChanged: (_) {
                                themeNotifier.smallTextScaleFactor();
                              },
                            ),
                            RadioListTile<double>(
                              title: Text(
                                'Regular',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              value: 1.0,
                              groupValue: themeNotifier.textScaleFactor,
                              onChanged: (_) {
                                themeNotifier.regularTextScaleFactor();
                              },
                            ),
                            RadioListTile<double>(
                              title: Text(
                                'Medium',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              value: 1.2,
                              groupValue: themeNotifier.textScaleFactor,
                              onChanged: (_) {
                                themeNotifier.mediumTextScaleFactor();
                              },
                            ),
                            RadioListTile<double>(
                              title: Text(
                                'Large',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              value: 1.5,
                              groupValue: themeNotifier.textScaleFactor,
                              onChanged: (_) {
                                themeNotifier.largeTextScaleFactor();
                              },
                            ),
                          ],
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
