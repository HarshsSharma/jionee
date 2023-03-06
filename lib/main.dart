import 'package:flutter/material.dart';
import 'package:infinity_scroll_view/core/helpers/dio_helper.dart';
import 'package:infinity_scroll_view/infinity_scroll_view/view/products_view.dart';
import 'package:infinity_scroll_view/infinity_scroll_view/view_model/products_provider.dart';
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
        create: (context) => ProductsProvider(),
        child: MaterialApp(
          title: 'Infinity',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ProductsScreen(),
        ));
  }
}
