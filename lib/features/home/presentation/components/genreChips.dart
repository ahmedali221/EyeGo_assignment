import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';

class GenreChips extends StatelessWidget {
  const GenreChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieCubit = context.read<MovieCubit>();

    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is! MovieLoaded) {
          return const SizedBox();
        }

        return Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  children: state.allGenres.map((genre) {
                    final isSelected =
                        movieCubit.selectedGenres.contains(genre);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(
                          genre.name,
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : null,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) => movieCubit.toggleGenre(genre),
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        showCheckmark: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
