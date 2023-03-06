import 'package:flutter/material.dart';

import '../../presentation/router/tab_navigator.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

int selectedTap = 0;

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              'Time Off',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
          const Divider(),
          DrawerItem(
            icon: Icons.timer,
            text: 'Time',
            isSelected: selectedTap == 0,
            onTap: () {
              Navigator.pushReplacementNamed(context, TabNavigatorRoutes.root);
              setState(() {
                selectedTap = 0;
              });
            },
          ),
          DrawerItem(
            icon: Icons.history,
            text: 'History',
            isSelected: selectedTap == 1,
            onTap: () {
              Navigator.pop(context);
              setState(() {
                selectedTap = 1;
              });
            },
          ),
          DrawerItem(
            icon: Icons.help,
            text: 'Help & Support',
            isSelected: selectedTap == 2,
            onTap: () {
              Navigator.pop(context);
              setState(() {
                selectedTap = 2;
              });
            },
          ),
          DrawerItem(
            icon: Icons.rate_review,
            text: 'Write a Review',
            isSelected: selectedTap == 3,
            onTap: () {
              Navigator.pop(context);
              setState(() {
                selectedTap = 3;
              });
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
        color: isSelected
            ? const Color(0xffE3EAFF).withOpacity(0.3)
            : Colors.transparent,
      ),
      child: ListTile(
        selected: true,
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}
