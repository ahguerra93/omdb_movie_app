import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/core/usecases/usecase.dart';
import 'package:omdb_movie_app/domain/entities/favorite_status.dart';
import 'package:omdb_movie_app/domain/repositories/favorites_repository.dart';

/// Use case to set favorite status about a movie by its ID.
class SetFavorite implements UseCase<FavoriteStatus, FavoriteStatus> {
  final FavoritesRepository repository;

  SetFavorite(this.repository);

  /// Executes the use case by delegating to the repository.
  @override
  Future<Either<Failure, FavoriteStatus>> call(FavoriteStatus item) async {
    return await repository.setFavoriteStatus(item);
  }
}
