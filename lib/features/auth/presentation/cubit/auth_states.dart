import 'package:eyego_assignment/features/auth/domain/entities/auth_user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final AuthUser user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {
  Unauthenticated();
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
