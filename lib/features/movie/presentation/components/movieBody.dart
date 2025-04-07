import 'package:eyego_assignment/features/movie/presentation/components/customDetailRow.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/model/movieDetails.dart';

class MovieBody extends StatelessWidget {
  final MovieDetails movieDetails;

  const MovieBody({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieDetails.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '"${movieDetails.tagline!}"',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Wrap(
              spacing: 16,
              children: [
                CustomDetailRow(
                  icon: Icons.star,
                  iconColor: Colors.amber,
                  text: movieDetails.voteAverage.toStringAsFixed(1),
                ),
                CustomDetailRow(
                  icon: Icons.schedule,
                  text:
                      '${movieDetails.runtime! ~/ 60}h ${movieDetails.runtime! % 60}m',
                ),
                CustomDetailRow(
                  icon: Icons.calendar_today,
                  text: movieDetails.releaseDate!.split('-')[0],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: movieDetails.genres
                  .map((genre) => Chip(
                        label: Text(genre.name),
                        backgroundColor: Colors.grey[200],
                      ))
                  .toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 24),
            child: Text(
              'Storyline',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              movieDetails.overview,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Official Website',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ElevatedButton(
                    onPressed: () =>
                        launchUrl(Uri.parse(movieDetails.homepage!)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'VISIT WEBSITE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
