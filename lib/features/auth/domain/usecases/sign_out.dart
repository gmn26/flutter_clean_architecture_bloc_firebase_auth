import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository repository;
  SignOut(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}