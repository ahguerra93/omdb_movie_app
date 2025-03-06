import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/data/datasources/favorites_data_source.dart';
import 'package:omdb_movie_app/domain/entities/favorite_status.dart';
import 'package:omdb_movie_app/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDataSource remoteDataSource;

  FavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FavoriteStatus>> getFavoriteStatus(String id) async {
    try {
      final result = await remoteDataSource.getFavoriteStatus(id);

      return Right(FavoriteStatus(id: id, favorite: result));
    } catch (e) {
      return Left(UnknownFailure(message: '$e'));
    }
  }

  @override
  Future<Either<Failure, FavoriteStatus>> setFavoriteStatus(
    FavoriteStatus item,
  ) async {
    try {
      await remoteDataSource.setFavoriteStatus(item);
      return Right(item);
    } catch (e) {
      return Left(UnknownFailure(message: '$e'));
    }
  }
}
