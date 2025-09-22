import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_event.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_state.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (prev, curr) => prev.password != curr.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (value) =>
              context.read<RegisterBloc>().add(PasswordChanged(value)),
          decoration: InputDecoration(
            labelText: "Password",
            errorText: state.password.isNotValid ? "Password too short" : null,
          ),
        );
      },
    );
  }
}