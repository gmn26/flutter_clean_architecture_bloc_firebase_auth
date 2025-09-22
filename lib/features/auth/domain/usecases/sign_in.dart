import 'package:fpdart/fpdart.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/core/error/failure.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;
  SignIn(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
