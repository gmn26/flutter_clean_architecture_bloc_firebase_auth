import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/user_entity.dart';

abstract class FirebaseAuthDataSource {
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> signUp(String email, String password);
  Future<void> signOut();
  Stream<UserEntity?> getUser();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user!;
    return UserEntity(uid: user.uid, email: user.email ?? "");
  }

  @override
  Future<UserEntity> signUp(String email, String password) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user!;
    return UserEntity(uid: user.uid, email: user.email ?? "");
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Stream<UserEntity?> getUser() {
    return firebaseAuth.authStateChanges().map(
      (user) => user != null
          ? UserEntity(uid: user.uid, email: user.email ?? "")
          : null,
    );
  }
}
