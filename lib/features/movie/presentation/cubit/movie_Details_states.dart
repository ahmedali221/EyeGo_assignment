import '../../domain/model/movieDetails.dart';

abstract class MovieDetailsState {
  const MovieDetailsState();
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetails movieDetails;
  const MovieDetailsLoaded(this.movieDetails);
}

class MovieDetailsError extends MovieDetailsState {
  final String message;
  const MovieDetailsError(this.message);
}
