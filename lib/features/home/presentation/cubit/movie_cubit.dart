import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/genre_model.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repository/movie_repo.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository repository;
  List<Movie> allMovies = [];
  List<GenreModel> _selectedGenres = [];
  String _searchQuery = '';

  MovieCubit(this.repository) : super(MovieInitial());

  Future<void> loadMoviesAndGenres() async {
    try {
      emit(MovieLoading());
      allMovies = await repository.getPopularMovies();
      final genres = await repository.getAllGenres();
      updateFilteredMovies(genres);
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  void searchMovies(String query) {
    _searchQuery = query;
    if (state is MovieLoaded) {
      updateFilteredMovies((state as MovieLoaded).allGenres);
    }
  }

  void toggleGenre(GenreModel genre) {
    if (_selectedGenres.contains(genre)) {
      _selectedGenres.remove(genre);
    } else {
      _selectedGenres.add(genre);
    }
    if (state is MovieLoaded) {
      updateFilteredMovies((state as MovieLoaded).allGenres);
    }
  }

  void updateFilteredMovies(List<GenreModel> allGenres) {
    final filtered = applyFilters(allMovies);
    emit(MovieLoaded(
      movies: filtered,
      allGenres: allGenres,
    ));
  }

  List<Movie> applyFilters(List<Movie> movies) {
    var filtered = _searchQuery.isEmpty
        ? movies
        : movies
            .where((m) =>
                m.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    if (_selectedGenres.isNotEmpty) {
      filtered = filtered.where((movie) {
        return movie.genreIds.any(
            (genreId) => _selectedGenres.any((genre) => genre.id == genreId));
      }).toList();
    }

    return filtered;
  }

  List<GenreModel> get selectedGenres => _selectedGenres;
  String get searchQuery => _searchQuery;
}
