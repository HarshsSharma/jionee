import 'package:flutter/material.dart';
import 'package:infinity_scroll_view/core/helpers/dio_helper.dart';
import 'package:infinity_scroll_view/list_view_selected/controller/selected_list_view_provider.dart';
import 'package:infinity_scroll_view/list_view_selected/view/list_view_selected.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SelectedListViewProvider(),
        child: MaterialApp(
          title: 'Infinity',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ListViewSelected(),
        ));
  }
}
