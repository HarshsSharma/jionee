import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widget/scaffold_drawer.dart';
import '../../../../router/tab_navigator.dart';
import '../../../../../common/widget/infinty_list_view.dart';
import '../../../../../common/widget/time_off_item_builder.dart';
import '../models/time_off_model.dart';
import '../view_model/time_off_view_model.dart';

class TimeOff extends StatelessWidget {
  const TimeOff({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldDrawer(
      appBar: AppBar(
        title: const Text('Time Off'),
      ),
      body: Consumer<TimeOffViewModel>(
        builder: (_, provider, __) {
          return InfinityListViewWidget<TimeOffModel>(
            loadData: (_) async {
              await provider.getData(context);
            },
            data: provider.data,
            itemBuilder: (ctx, i) {
              return TimeOffItemBuilder(
                data: provider.data[i],
                onTap: () {
                  provider.setSelectedRequest(provider.data[i]);
                  Navigator.pushNamed(
                    context,
                    TabNavigatorRoutes.timeOffItemDetails,
                  );
                },
              );
            },
            separatorBuilder: const Divider(),
            onScrollEnd: (nextPage) async {
              await provider.getData(context);
            },
            initalLoaderWidget: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            TabNavigatorRoutes.addTimeOffRequest,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
