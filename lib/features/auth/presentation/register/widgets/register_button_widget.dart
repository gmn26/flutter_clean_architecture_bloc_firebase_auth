import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_event.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_state.dart';
import 'package:formz/formz.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
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
              ? () => context.read<RegisterBloc>().add(RegisterSubmitted())
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