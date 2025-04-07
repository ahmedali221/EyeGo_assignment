import 'package:eyego_assignment/features/home/presentation/components/movies_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eyego_assignment/features/home/presentation/cubit/movie_cubit.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_states.dart';
import '../../../auth/presentation/pages/loginPage.dart';
import '../components/genreChips.dart';
import '../components/movieSearchDelegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().loadMoviesAndGenres();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Loginpage()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movie App'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => context.read<AuthCubit>().signOut(),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const GenreChips(),
              const Expanded(
                child: MovieGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
