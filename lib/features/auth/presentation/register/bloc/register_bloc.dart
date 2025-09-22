import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/email.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/entities/password.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_event.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_state.dart';
import 'package:formz/formz.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(const RegisterState()) {
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

    on<RegisterSubmitted>((event, emit) async {
      if (!state.isValid) return;

      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));

      final result = await authRepository.signUp(
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
