import 'package:eyego_assignment/features/movie/presentation/pages/movieDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';
import 'movieCardWidget.dart';

class MovieGrid extends StatelessWidget {
  const MovieGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieInitial) {
          return const Center(child: Text('Loading movies...'));
        }

        if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MovieError) {
          return Center(
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}'),
                ElevatedButton(
                  onPressed: () =>
                      context.read<MovieCubit>().loadMoviesAndGenres(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is MovieLoaded) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return const Center(
              child: Text('No movies found.'),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(
                movie: movie,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailsPage(movieId: movie.id)));
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
