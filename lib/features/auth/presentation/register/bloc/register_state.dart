import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/email.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/password.dart';
import 'package:formz/formz.dart';

class RegisterState extends Equatable {
  final Email email;
  final Password password;
  final FormzSubmissionStatus submissionStatus;
  final String? errorMessage;

  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  bool get isValid => Formz.validate([email, password]);

  RegisterState copyWith({
    Email? email,
    Password? password,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, submissionStatus, errorMessage];
}
