import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthFirebaseDataSource(this._firebaseAuth);

  // Sign In
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  // Sign Up
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userCredential.user?.updateDisplayName(name);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  // User Fetch
  Future<User?> getCurrentUser() async => _firebaseAuth.currentUser;

  // Sign Out
  Future<void> signOut() async => _firebaseAuth.signOut();

  // reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Checks auth state
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}
