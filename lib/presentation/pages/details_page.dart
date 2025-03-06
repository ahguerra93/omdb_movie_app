import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_movie_app/presentation/bloc/favorites/bloc/favorites_bloc.dart';

import '../bloc/movie/movie_bloc.dart';
import '../bloc/movie/movie_event.dart';
import '../bloc/movie/movie_state.dart';

/// Page displaying detailed information about a selected movie.
class DetailsPage extends StatelessWidget {
  final String movieId;

  const DetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    // Fetch movie details when the page is built.
    final double screenHeight = MediaQuery.of(context).size.height;
    final double? posterHeight = screenHeight < 920 ? screenHeight / 2 : null;
    context.read<MovieBloc>().add(GetMovieDetailsEvent(movieId));
    context.read<FavoritesBloc>().add(GetFavoriteStatusEvent(id: movieId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        actions: [
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              late IconData icon;
              late Color? iconColor;
              if (state is FavoritesLoading) {
                icon = Icons.favorite;
                iconColor =
                    Theme.of(context).primaryColor.withValues(alpha: 0.3);
              } else if (state is FavoritesSuccess) {
                icon = state.value ? Icons.favorite : Icons.favorite_outline;
                iconColor = Theme.of(context).primaryColor;
              } else {
                icon = Icons.favorite_outline;
                iconColor = Theme.of(context).primaryColor;
              }
              return InkWell(
                onTap: () => context
                    .read<FavoritesBloc>()
                    .add(SetFavoriteEvent(id: movieId)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: Icon(
                      icon,
                      key: Key('$state'),
                      color: iconColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsLoaded) {
            final details = state.movieDetails;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      state.movieDetails.poster,
                      height: posterHeight,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    details.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Year: ${details.year}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Director: ${details.director}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Actors: ${details.actors}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Runtime: ${details.runtime}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Genre: ${details.genre}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  const Text(
                    'Plot',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(details.plot, style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else if (state is MovieError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<MovieBloc>()
                          .add(GetMovieDetailsEvent(movieId));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Unexpected error occurred.'));
          }
        },
      ),
    );
  }
}
