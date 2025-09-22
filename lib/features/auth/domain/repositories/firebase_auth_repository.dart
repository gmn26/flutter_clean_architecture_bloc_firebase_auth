import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/core/error/failure.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user == null) {
        return left(AuthFailure("No user found"));
      }
      return right(UserEntity(uid: user.uid, email: user.email ?? ""));
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e.message ?? "Authentication error"));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user == null) {
        return left(AuthFailure("Sign up failed"));
      }
      return right(UserEntity(uid: user.uid, email: user.email ?? ""));
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e.message ?? "Authentication error"));
    } catch (e) {
      return left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<UserEntity?> getUser() {
    return _firebaseAuth.authStateChanges().map(
          (user) => user != null
          ? UserEntity(uid: user.uid, email: user.email ?? "")
          : null,
    );
  }
}
