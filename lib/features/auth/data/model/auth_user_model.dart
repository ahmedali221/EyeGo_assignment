import 'package:eyego_assignment/features/auth/domain/entities/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    required super.id,
    required super.email,
    super.name,
  });

  factory AuthUserModel.fromFirebase(User user) {
    return AuthUserModel(
        id: user.uid, email: user.email ?? '', name: user.displayName);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
