import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants.dart';
import '../../domain/model/movieDetails.dart';

class MovieDetailsDataSource {
  Future<MovieDetails> getMovieDetails(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return MovieDetails.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load movie details - Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}
