import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omdb_movie_app/domain/entities/favorite_status.dart';
import 'package:omdb_movie_app/domain/usecases/get_favorite_status.dart';
import 'package:omdb_movie_app/domain/usecases/set_favorite.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final SetFavorite setFavorite;
  final GetFavoriteStatus getFavoriteStatus;
  FavoritesBloc({
    required this.getFavoriteStatus,
    required this.setFavorite,
  }) : super(FavoritesInitial()) {
    on<SetFavoriteEvent>((event, emit) async {
      if (state is! FavoritesSuccess) return;
      final newValue = !(state as FavoritesSuccess).value;
      emit(FavoritesLoading());
      final result = await setFavorite(
        FavoriteStatus(id: event.id, favorite: newValue),
      );
      result.fold((failure) {
        emit(const FavoritesError(message: 'Failed updating movie state'));
        emit(FavoritesInitial());
      }, (favorite) {
        emit(FavoritesSuccess(value: favorite.favorite));
      });
    });
    on<GetFavoriteStatusEvent>((event, emit) async {
      emit(FavoritesLoading());
      final result = await getFavoriteStatus(event.id);
      result.fold((failure) {
        emit(const FavoritesError(
            message: 'Failed getting movie favorite state'));
        emit(FavoritesInitial());
      }, (favorite) {
        emit(FavoritesSuccess(value: favorite.favorite));
      });
    });
  }
}
