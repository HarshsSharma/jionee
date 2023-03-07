import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/products_provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsProvider>().infinityScrollWithProducts();
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
                controller: context.read<ProductsProvider>().scrollController,
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
