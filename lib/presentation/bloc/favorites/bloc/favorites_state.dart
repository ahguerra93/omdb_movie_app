part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesSuccess extends FavoritesState {
  final bool value;
  const FavoritesSuccess({
    required this.value,
  });
}

final class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError({
    required this.message,
  });
}
