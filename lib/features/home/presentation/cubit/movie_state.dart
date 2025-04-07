import '../../data/model/genre_model.dart';
import '../../domain/entities/movie.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final List<GenreModel> allGenres;

  MovieLoaded({
    required this.movies,
    required this.allGenres,
  });
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}
