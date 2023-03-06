import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../core/constants/end_points.dart';
import '../../core/helpers/dio_helper.dart';
import '../model/product_model.dart';

class ProductsProvider extends ChangeNotifier {
  @override
  void dispose() {
    debugPrint('dispose');
    _scrollController.dispose();
    super.dispose();
  }

  int productsTotal = 0;
  bool loadMore = false;
  int skip = 0;
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  List<Product> products = [];
  Future<void> getProducts() async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.product, query: {'limit': 20, 'skip': skip});
      productsTotal = response.data['total'];
      for (final product in response.data['products']) {
        products.add(Product.fromJson(product));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void infinityScrollWithProducts() async {
    await getProducts();
    notifyListeners();
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          if (skip < productsTotal && !loadMore) {
            loadMore = true;
            notifyListeners();
            skip += 20;
            await getProducts();
            loadMore = false;
            notifyListeners();
          }
        }
      }
    });
  }
}
