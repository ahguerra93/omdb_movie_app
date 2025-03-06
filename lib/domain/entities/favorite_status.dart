import 'package:equatable/equatable.dart';

/// Entity representing a movie.
/// This is the core representation of a movie used throughout the app.
class FavoriteStatus extends Equatable {
  final String id;
  final bool favorite;

  const FavoriteStatus({
    required this.id,
    required this.favorite,
  });

  @override
  List<Object?> get props => [id, favorite];
}
