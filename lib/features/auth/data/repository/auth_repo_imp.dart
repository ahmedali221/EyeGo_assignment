import 'package:eyego_assignment/features/auth/data/datasource/auth_firebase_data_source.dart';
import 'package:eyego_assignment/features/auth/data/model/auth_user_model.dart';
import 'package:eyego_assignment/features/auth/domain/entities/auth_user.dart';
import 'package:eyego_assignment/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImp extends AuthRepo {
  final AuthFirebaseDataSource _dataSource;
  AuthRepoImp(this._dataSource);

  @override
  Future<AuthUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user =
          await _dataSource.signInWithEmailAndPassword(email, password);
      return user != null ? AuthUserModel.fromFirebase(user.user!) : null;
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<AuthUser?> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final user = await _dataSource.createUserWithEmailAndPassword(
          email, password, name);
      return AuthUserModel.fromFirebase(user);
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final user = await _dataSource.getCurrentUser();
    return user != null ? AuthUserModel.fromFirebase(user) : null;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _dataSource.sendPasswordResetEmail(email);
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _dataSource
        .authStateChanges()
        .map((user) => user != null ? AuthUserModel.fromFirebase(user) : null);
  }
}
