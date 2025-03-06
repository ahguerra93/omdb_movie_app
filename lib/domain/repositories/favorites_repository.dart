import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/domain/entities/favorite_status.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, FavoriteStatus>> getFavoriteStatus(
    String id,
  );
  Future<Either<Failure, FavoriteStatus>> setFavoriteStatus(
    FavoriteStatus item,
  );
}
