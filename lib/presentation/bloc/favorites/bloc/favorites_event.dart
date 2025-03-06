part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class SetFavoriteEvent extends FavoritesEvent {
  final String id;

  const SetFavoriteEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class GetFavoriteStatusEvent extends FavoritesEvent {
  final String id;

  const GetFavoriteStatusEvent({required this.id});

  @override
  List<Object> get props => [id];
}
