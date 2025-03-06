import 'package:hive_flutter/hive_flutter.dart';
import 'package:omdb_movie_app/domain/entities/favorite_status.dart';

/// Interface for fetching Authentication data.
abstract class FavoritesDataSource {
  Future<bool> getFavoriteStatus(String id);
  Future<void> setFavoriteStatus(FavoriteStatus item);
}

class FavoritesDataSourceImpl implements FavoritesDataSource {
  @override
  Future<bool> getFavoriteStatus(String id) async {
    final Box<bool> favoritesBox = await Hive.openBox<bool>('favorites');
    return favoritesBox.get(id) ?? false;
  }

  @override
  Future<void> setFavoriteStatus(FavoriteStatus item) async {
    final Box<bool> favoritesBox = await Hive.openBox<bool>('favorites');
    await favoritesBox.put(item.id, item.favorite);
  }
}
