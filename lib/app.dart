import 'package:eyego_assignment/features/auth/data/datasource/auth_firebase_data_source.dart';
import 'package:eyego_assignment/features/auth/data/repository/auth_repo_imp.dart';
import 'package:eyego_assignment/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:eyego_assignment/features/auth/presentation/cubit/auth_states.dart';
import 'package:eyego_assignment/features/auth/presentation/pages/loginPage.dart';
import 'package:eyego_assignment/features/movie/data/data%20source/movieDetails_dataSource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/data/datasource/movie_datasource.dart';
import 'features/home/data/repository/movie_repo_imp.dart';
import 'features/home/presentation/cubit/movie_cubit.dart';
import 'features/home/presentation/pages/homepage.dart';
import 'features/movie/data/repo/movieDetailsRepoImp.dart';
import 'features/movie/presentation/cubit/movie_Details_cubit.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authRepo = AuthRepoImp(AuthFirebaseDataSource(FirebaseAuth.instance));
  final _movieRepo = MovieRepositoryImpl(MovieDataSource());
  final _movieDetailsRepo =
      MovieDetailsRepositoryImpl(MovieDetailsDataSource());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(_movieRepo)..loadMoviesAndGenres(),
        ),
        BlocProvider(create: (context) => MovieDetailsCubit(_movieDetailsRepo)),
        BlocProvider(create: (context) => AuthCubit(_authRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "EyesGo Assignment",
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
              return Loginpage();
            }
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            if (state is Authenticated) {
              return const HomePage();
            }
              return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          },
        ),
      ),
    );
  }
}
