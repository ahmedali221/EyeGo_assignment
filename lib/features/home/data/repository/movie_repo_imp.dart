import '../../domain/entities/movie.dart';
import '../../domain/repository/movie_repo.dart';
import '../datasource/movie_datasource.dart';
import '../model/genre_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource movieRemoteDataSource;

  MovieRepositoryImpl(this.movieRemoteDataSource);

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final movies = await movieRemoteDataSource.getPopularMovies();
      return movies;
    } catch (e) {
      throw Exception('Failed to fetch popular movies');
    }
  }

  @override
  Future<List<GenreModel>> getAllGenres() async {
    try {
      final genres = await movieRemoteDataSource.getAllGenres();
      return genres;
    } catch (e) {
      throw Exception('Failed to fetch genres');
    }
  }
}
