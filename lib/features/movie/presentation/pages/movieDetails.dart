import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/movieBody.dart';
import '../components/movieHeader.dart';
import '../cubit/movie_Details_cubit.dart';
import '../cubit/movie_Details_states.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final movieDetailsCubit = context.read<MovieDetailsCubit>();
    movieDetailsCubit.getMovieDetails(movieId);

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MovieDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is MovieDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  MovieHeader(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original${state.movieDetails.posterPath}'),
                  MovieBody(movieDetails: state.movieDetails),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
