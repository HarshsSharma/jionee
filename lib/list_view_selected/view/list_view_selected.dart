import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        actions: provider.inSelctionMode
            ? [
                IconButton(
                    onPressed: () {
                      provider.clearSelection();
                    },
                    icon: const Icon(Icons.clear)),
                Center(
                  child: Text(
                    provider.listItems
                        .where(
                          (element) => element.isChecked,
                        )
                        .length
                        .toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 5)
              ]
            : null,
      ),
      body: ListView.builder(
          itemCount: provider.listItems.length,
          itemBuilder: (context, index) => ListTile(
                selected: provider.listItems[index].isChecked,
                selectedTileColor: Colors.blueGrey,
                leading: CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: provider.listItems[index].isChecked
                          ? Colors.blue
                          : Colors.white,
                    )),
                title: Text(provider.listItems[index].title),
                subtitle: Text(provider.listItems[index].subTitle),
                onTap: () {
                  if (provider.inSelctionMode) {
                    provider.toggleChecked(index);
                  }
                },
                onLongPress: () {
                  if (provider.inSelctionMode) {
                    return;
                  } else {
                    provider.enterInSelectionMode(index);
                  }
                },
              )),
    );
  }
}
