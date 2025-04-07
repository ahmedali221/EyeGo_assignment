import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repo/movieDetailsRepo.dart';
import 'movie_Details_states.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsRepository repository;

  MovieDetailsCubit(this.repository) : super(MovieDetailsInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movieDetails = await repository.getMovieDetails(movieId);
      emit(MovieDetailsLoaded(movieDetails));
    } catch (e) {
      emit(MovieDetailsError('Failed to load movie details'));
    }
  }
}
