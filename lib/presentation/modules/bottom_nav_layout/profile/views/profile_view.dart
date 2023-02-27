import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../styles/theme_mode_logic.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ModelTheme>(
        builder: (_, themeNotifier, __) {
          return Column(
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('Default'),
                value: ThemeMode.system,
                groupValue: themeNotifier.themeMode,
                onChanged: (value) {
                  themeNotifier.changeCurrentTheme(ThemeMode.system.name);
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Dark'),
                value: ThemeMode.dark,
                groupValue: themeNotifier.themeMode,
                onChanged: (value) {
                  themeNotifier.changeCurrentTheme(ThemeMode.dark.name);
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Light'),
                value: ThemeMode.light,
                groupValue: themeNotifier.themeMode,
                onChanged: (value) {
                  themeNotifier.changeCurrentTheme(ThemeMode.light.name);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
