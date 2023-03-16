import 'dart:convert';

Movies moviesFromJson(String str) => Movies.fromJson(json.decode(str));

class Movies {
  Movies({
    this.page,
    this.results,
    this.totalPages,
  });

  int? page;
  List<MoviesData>? results;
  int? totalPages;

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        page: json['page'],
        results:
            List<MoviesData>.from(json['results'].map((x) => MoviesData.fromJson(x))),
        totalPages: json['total_pages'],
      );
}

class MoviesData {
  MoviesData({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory MoviesData.fromJson(Map<String, dynamic> json) => MoviesData(
        id: json['id'],
        title: json['title'],
      );
}
