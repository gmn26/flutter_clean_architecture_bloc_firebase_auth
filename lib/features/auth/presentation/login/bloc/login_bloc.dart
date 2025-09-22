import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/email.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/password.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_event.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      final email = Email.dirty(event.value);
      final isValid = Formz.validate([email, state.email]);
      emit(state.copyWith(email: email, isValid: isValid));
    });

    on<PasswordChanged>((event, emit) {
      final password = Password.dirty(event.value);
      final isValid = Formz.validate([password, state.password]);
      emit(state.copyWith(password: password, isValid: isValid));
    });

    on<LoginSubmitted>((event, emit) async {
      if (!state.isValid) return;

      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

      final result = await authRepository.signIn(
        state.email.value,
        state.password.value,
      );

      result.match(
        (failure) => emit(
          state.copyWith(
            submissionStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (user) => emit(
          state.copyWith(submissionStatus: FormzSubmissionStatus.success),
        ),
      );
    });
  }
}
