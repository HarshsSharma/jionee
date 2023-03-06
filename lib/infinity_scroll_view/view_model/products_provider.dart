import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../core/constants/end_points.dart';
import '../../core/helpers/dio_helper.dart';
import '../model/product_model.dart';

class ProductsProvider extends ChangeNotifier {
  int productsTotal = 0;
  bool loadMore = false;

  List<Product> products = [];
  Future<void> getProducts(int skip) async {
    try {
      final response = await DioHelper.getData(
          url: EndPoints.product, query: {'limit': 20, 'skip': skip});
      productsTotal = response.data['total'];
      for (final product in response.data['products']) {
        products.add(Product.fromJson(product));
      }
      notifyListeners();
      log(products.length.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  void infinityScroll(ScrollController scrollController, int skip) {
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          if (skip < productsTotal && !loadMore) {
            loadMore = true;
            notifyListeners();
            skip += 20;
            await getProducts(skip);
            loadMore = false;
            notifyListeners();
          }
        }
      }
    });
  }
}
