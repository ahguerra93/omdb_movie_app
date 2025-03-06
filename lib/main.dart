import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:omdb_movie_app/data/datasources/authentication_data_source.dart';
import 'package:omdb_movie_app/data/datasources/favorites_data_source.dart';
import 'package:omdb_movie_app/data/repositories/authentication_repository_impl.dart';
import 'package:omdb_movie_app/data/repositories/favorites_repository_impl.dart';
import 'package:omdb_movie_app/domain/usecases/get_favorite_status.dart';
import 'package:omdb_movie_app/domain/usecases/login.dart';
import 'package:omdb_movie_app/domain/usecases/set_favorite.dart';
import 'package:omdb_movie_app/presentation/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:omdb_movie_app/presentation/bloc/login/login_bloc.dart';
import 'package:omdb_movie_app/presentation/pages/login_page.dart';

import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/usecases/get_movie_details.dart';
import 'domain/usecases/search_movies.dart';
import 'presentation/bloc/movie/movie_bloc.dart';

// Entry point of the Flutter application.
void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  // Calls the root widget of the application.
  runApp(MyApp());
}

// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dependency Injection:
    // - Initialize an HTTP client to handle API requests.
    final http.Client client = http.Client();

    // - Create an instance of the remote data source, which interacts with the OMDb API.
    final movieRemoteDataSource = MovieRemoteDataSourceImpl(client: client);
    // - Create an instance of the remote data source, which interacts with the Authentication services.
    final authenticationRemoteDataSource = AuthenticationDataSourceImpl();

    final favoritesDataSource = FavoritesDataSourceImpl();

    // - Create an instance of the repository, which abstracts data operations
    //   and provides a single source of truth for the app.
    final movieRepository =
        MovieRepositoryImpl(remoteDataSource: movieRemoteDataSource);
    final authenticationRepository = AuthenticationRepositoryImpl(
        authenticationDataSource: authenticationRemoteDataSource);
    final favoritesRepository =
        FavoritesRepositoryImpl(remoteDataSource: favoritesDataSource);

    // - Initialize use cases for searching movies and fetching movie details.
    final searchMovies = SearchMovies(movieRepository);
    final getMovieDetails = GetMovieDetails(movieRepository);
    // - Initialize use cases for Authentication State.
    final login = Login(authenticationRepository);

    final setFavorite = SetFavorite(favoritesRepository);
    final getFavoriteStatus = GetFavoriteStatus(favoritesRepository);

    // The `BlocProvider` is used to make the `MovieBloc` available to the widget tree.
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // Create the `MovieBloc` and inject the required use cases for state management.
          create: (_) => MovieBloc(
            searchMovies: searchMovies,
            getMovieDetails: getMovieDetails,
          ),
          // Define the app's structure and configuration.
        ),
        BlocProvider(
          create: (context) => LoginBloc(login: login),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(
            getFavoriteStatus: getFavoriteStatus,
            setFavorite: setFavorite,
          ),
        ),
      ],
      child: MaterialApp(
        // Remove the debug banner from the app.
        debugShowCheckedModeBanner: false,

        // Set the title of the application.
        title: 'OMDb Movie Search',

        // Apply a global theme to the app.
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // Set the initial screen of the app to the `SearchPage`.
        home: const LoginPage(),
      ),
    );
  }
}
