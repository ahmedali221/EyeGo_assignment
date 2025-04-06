import 'dart:async';

import 'package:eyego_assignment/features/auth/domain/entities/auth_user.dart';
import 'package:eyego_assignment/features/auth/domain/repository/auth_repo.dart';
import 'package:eyego_assignment/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  StreamSubscription<AuthUser?>? _authSubscription;
  AuthCubit(this._authRepo)
      : super(
          AuthLoading(),
        ) {
    initialize();
  }

  void initialize() {
    checkCurrentUser();
    _authSubscription = _authRepo.authStateChanges().listen(handleAuth);
  }

  void handleAuth(AuthUser? user) {
    if (user == null) {
      emit(Unauthenticated());
    } else {
      emit(Authenticated(user));
    }
  }

  Future<void> checkCurrentUser() async {
    try {
      final user = await _authRepo.getCurrentUser();
      user != null ? emit(Authenticated(user)) : emit(Unauthenticated());
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.signInWithEmailAndPassword(email, password);
      emit(Authenticated(user!));
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      final user =
          await _authRepo.signUpWithEmailAndPassword(email, password, name);
      emit(Authenticated(user!));
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _authRepo.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
