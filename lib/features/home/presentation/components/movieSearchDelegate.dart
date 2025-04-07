import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../movie/presentation/pages/movieDetails.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search movies...';

  @override
  TextStyle get searchFieldStyle => const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
        context.read<MovieCubit>().searchMovies('');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text(
          'Please enter a search term',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    context.read<MovieCubit>().searchMovies(query);
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return Center(
              child: Column(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.abc_rounded, size: 48, color: Colors.grey),
                  Text(
                    'No movies found for "$query"',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: movies.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                  ),
                ),
                title: Text(
                  movie.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.releaseDate.split('-')[0]),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        Text(movie.voteAverage.toStringAsFixed(1)),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(movieId: movie.id),
                    ),
                  );
                },
              );
            },
          );
        }

        return const Center(child: Text('Search for movies'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.search, size: 48, color: Colors.grey),
            Text(
              'Start typing to search movies',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    context.read<MovieCubit>().searchMovies(query);
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return const Center(
              child: Text('No suggestions found'),
            );
          }

          return ListView.separated(
            itemCount: movies.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                  ),
                ),
                title: Text(movie.title),
                subtitle: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.releaseDate.split('-')[0]),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        Text(movie.voteAverage.toStringAsFixed(1)),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(movieId: movie.id),
                    ),
                  );
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
