import 'package:fpdart/fpdart.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/core/error/failure.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(String email, String password);
  Future<void> signOut();
  Stream<UserEntity?> getUser();
}
