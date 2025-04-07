import '../../data/model/genre_model.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies();
  Future<List<GenreModel>> getAllGenres();
}
