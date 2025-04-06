import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/data/datasource/auth_firebase_data_source.dart';
import 'features/auth/data/repository/auth_repo_imp.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/cubit/auth_states.dart';
import 'features/auth/presentation/pages/loginPage.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authRepo = AuthRepoImp(AuthFirebaseDataSource(FirebaseAuth.instance));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
            return const HomePage();
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("data"),
      ),
    );
  }
}
