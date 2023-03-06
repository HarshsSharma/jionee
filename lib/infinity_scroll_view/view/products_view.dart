import 'package:flutter/material.dart';
import 'package:infinity_scroll_view/infinity_scroll_view/view_model/products_provider.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ScrollController _controller;
  int skip = 0;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    context.read<ProductsProvider>().getProducts(skip);
    context.read<ProductsProvider>().infinityScroll(_controller, skip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: context.watch<ProductsProvider>().products.length,
                itemBuilder: (context, index) => ListTile(
                    title: Text(context
                            .watch<ProductsProvider>()
                            .products[index]
                            .title ??
                        'No Title'),
                    leading: CircleAvatar(
                      backgroundImage: Image.network(
                        context
                                .watch<ProductsProvider>()
                                .products[index]
                                .thumbnail ??
                            'No Title',
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.not_interested_rounded),
                      ).image,
                    )),
              ),
            ),
            if (context.watch<ProductsProvider>().loadMore)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ));
  }
}
