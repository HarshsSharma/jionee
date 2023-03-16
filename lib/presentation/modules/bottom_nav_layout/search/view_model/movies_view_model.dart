import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jionee/common/extensions/loader.dart';
import '../model/movies_model.dart';
import '../repo/movies_repo.dart';

class MoviesViewModel extends ChangeNotifier {
  final MoviesSevice moviesSevice;
  MoviesViewModel(this.moviesSevice);

  int? _totalPages;
  List<MoviesData> _data = [];

  int get totalPages => _totalPages!;
  List<MoviesData> get data => [..._data];

  Future<void> getMovies({
    int page = 1,
    String name = '',
    required BuildContext context,
  }) async {
    if (page == 1) {
      _data = [];
    }
    try {
      context.showLoader();
      final response = await moviesSevice
          .getMovies(
            MoviesInput(
              page: page,
              title: name,
            ),
          )
          .whenComplete(() => context.hideLoader());
      _totalPages = response.totalPages!;
      _data.addAll(response.results!);
      notifyListeners();
      log('Data lenght: ${_data.length}\nPage number: $page\nMovie name: $name\nTotal pages: $_totalPages');
    } catch (e) {
      rethrow;
    }
  }
}
