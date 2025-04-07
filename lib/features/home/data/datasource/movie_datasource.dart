import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/genre_model.dart';
import '../model/movie_model.dart';
import '../../../../core/constants.dart';

class MovieDataSource {
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => MovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<GenreModel>> getAllGenres() async {
    final response = await http.get(
      Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['genres'] as List)
          .map((json) => GenreModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }
}
