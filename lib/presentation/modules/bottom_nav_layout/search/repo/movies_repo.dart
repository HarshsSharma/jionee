import 'package:http/http.dart' as http;

import '../model/movies_model.dart';

abstract class MoviesSevice {
  Future<Movies> getMovies(MoviesInput input);
}

class MoviesSeviceImpl extends MoviesSevice {
  @override
  Future<Movies> getMovies(MoviesInput input) async {
    final Uri uri = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=a5b301db8963521ec12d091f8ce0686e&language=en-US&query=${input.title}&page=${input.page}&include_adult=false',
    );
    final response = await http.get(
      uri,
    );

    Movies movies = moviesFromJson(response.body);
    return movies;
  }
}

class MoviesInput {
  final String title;
  final int page;
  const MoviesInput({
    required this.title,
    required this.page,
  });
}
