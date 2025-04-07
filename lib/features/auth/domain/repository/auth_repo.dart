import '../entities/auth_user.dart';

abstract class AuthRepo {
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password);
  Future<AuthUser?> signUpWithEmailAndPassword(
      String email, String password, String name);

  Future<void> signOut();
  Future<AuthUser?> getCurrentUser();

  Stream<AuthUser?> authStateChanges();
}
