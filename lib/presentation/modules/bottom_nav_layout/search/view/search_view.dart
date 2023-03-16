import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../common/widget/dropdown_widget.dart';
import '../view_model/movies_view_model.dart';

List<String> _data = const [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
];

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Draggable(child: child, feedback: feedback)
              Consumer<MoviesViewModel>(
                builder: (context, provider, _) {
                  return DropDownWidget(
                    data: provider.data.map((e) => e.title!).toList(),
                    isRequired: true,
                    labelText: 'Movies',
                    loadData: () {
                      return provider.getMovies(context: context);
                    },
                    onSubmitKeyboard: (value) async {
                      await provider.getMovies(name: value!, context: context);
                    },
                    multiSelection: false,
                    onScrollEnd: (nextPage, text) {
                      provider.getMovies(
                        page: nextPage,
                        context: context,
                        name: text ?? '',
                      );
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select a movie';
                      }
                      return null;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
      // body: Center(
      //   child: TextButton(
      //     child: const Text('Show bottom sheet'),
      //     onPressed: () {
      //       context.showBottomSheetWidget(
      //         backgroundColor: Colors.white,
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: const [
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      // ),
