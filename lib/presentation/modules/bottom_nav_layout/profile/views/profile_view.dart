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
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Theme Mode',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Default'),
                  value: ThemeMode.system,
                  groupValue: themeNotifier.themeMode,
                  onChanged: (value) {
                    themeNotifier.changeCurrentTheme(value!.name);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Dark'),
                  value: ThemeMode.dark,
                  groupValue: themeNotifier.themeMode,
                  onChanged: (value) {
                    themeNotifier.changeCurrentTheme(value!.name);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Light'),
                  value: ThemeMode.light,
                  groupValue: themeNotifier.themeMode,
                  onChanged: (value) {
                    themeNotifier.changeCurrentTheme(value!.name);
                  },
                ),
                ListTile(
                  title: Text(
                    'Font Size',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                RadioListTile<double>(
                  title: const Text('Small'),
                  value: 0.8,
                  groupValue: themeNotifier.textScaleFactor,
                  onChanged: (_) {
                    themeNotifier.smallTextScaleFactor();
                  },
                ),
                RadioListTile<double>(
                  title: const Text('Regular'),
                  value: 1.0,
                  groupValue: themeNotifier.textScaleFactor,
                  onChanged: (_) {
                    themeNotifier.regularTextScaleFactor();
                  },
                ),
                RadioListTile<double>(
                  title: const Text('Medium'),
                  value: 1.2,
                  groupValue: themeNotifier.textScaleFactor,
                  onChanged: (_) {
                    themeNotifier.mediumTextScaleFactor();
                  },
                ),
                RadioListTile<double>(
                  title: const Text('Large'),
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
      ),
    );
  }
}
