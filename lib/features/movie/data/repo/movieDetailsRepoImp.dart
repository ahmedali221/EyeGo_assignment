import '../../domain/model/movieDetails.dart';
import '../../domain/repo/movieDetailsRepo.dart';
import '../data source/movieDetails_dataSource.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsDataSource dataSource;

  MovieDetailsRepositoryImpl(this.dataSource);

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    return await dataSource.getMovieDetails(movieId);
  }
}
