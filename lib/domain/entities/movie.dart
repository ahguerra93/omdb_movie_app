import 'package:equatable/equatable.dart';

/// Entity representing a movie.
/// This is the core representation of a movie used throughout the app.
class Movie extends Equatable {
  final String title;
  final String year;
  final String imdbID;
  final String poster;

  Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.poster,
  });

  @override
  List<Object?> get props => [title, year, imdbID, poster];
}
