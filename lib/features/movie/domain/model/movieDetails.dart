class MovieDetails {
  final int id;
  final String title;
  final String? posterPath;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String? releaseDate;
  final int? runtime;
  final List<Genre> genres;
  final String? homepage;
  final String? backdropPath;
  final String? tagline;
  final String? status;

  MovieDetails({
    required this.id,
    required this.title,
    this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    this.releaseDate,
    this.runtime,
    required this.genres,
    this.homepage,
    this.backdropPath,
    this.tagline,
    this.status,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      genres:
          (json['genres'] as List?)?.map((e) => Genre.fromJson(e)).toList() ??
              [],
      homepage: json['homepage'],
      backdropPath: json['backdrop_path'],
      tagline: json['tagline'],
      status: json['status'],
    );
  }

  String get posterUrl => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : 'https://via.placeholder.com/500x750?text=No+Poster';

  String get backdropUrl => backdropPath != null
      ? 'https://image.tmdb.org/t/p/original$backdropPath'
      : 'https://via.placeholder.com/1920x1080?text=No+Backdrop';
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
