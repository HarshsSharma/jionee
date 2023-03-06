import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinity_scroll_view/list_view_selected/controller/selected_list_view_provider.dart';
import 'package:provider/provider.dart';

class ListViewSelected extends StatelessWidget {
  const ListViewSelected({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelectedListViewProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected List View'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => CheckboxListTile(
                title: Text(provider.listItems[index].title),
                subtitle: Text(provider.listItems[index].subTitle),
                value: provider.listItems[index].isChecked,
                onChanged: (value) {
                  provider.toggleChecked(index);
                },
              )),
    );
  }
}
