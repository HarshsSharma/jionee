import 'package:flutter/material.dart';
import '../../../../common/extensions/show_bottom_sheet.dart';

List<String> _data = const [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
];

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => debugPrint(value),
            itemBuilder: (context) {
              return _data
                  .map(
                    (e) => PopupMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      ),
      body: Center(
        child: TextButton(
          child: const Text('Show bottom sheet'),
          onPressed: () {
            context.showBottomSheetWidget(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
