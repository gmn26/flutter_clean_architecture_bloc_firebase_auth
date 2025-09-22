import 'package:fpdart/fpdart.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/core/error/failure.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/data/datasource/firebase_auth_data_source.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  const AuthRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    try {
      final user = await _dataSource.signIn(email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password) async {
    try {
      final user = await _dataSource.signUp(email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> signOut() async {
    return _dataSource.signOut();
  }

  @override
  Stream<UserEntity?> getUser() {
    return _dataSource.getUser();
  }
}
