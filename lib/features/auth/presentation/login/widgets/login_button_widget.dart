import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_event.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_state.dart';
import 'package:formz/formz.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, curr) =>
      prev.submissionStatus != curr.submissionStatus &&
          curr.submissionStatus.isFailure,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage ?? "Login failed")),
        );
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isValid && !state.submissionStatus.isInProgress
              ? () => context.read<LoginBloc>().add(LoginSubmitted())
              : null,
          child: state.submissionStatus.isInProgress
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : const Text("Login"),
        );
      },
    );
  }
}