import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_event.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_state.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (prev, curr) => prev.email != curr.email,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<RegisterBloc>().add(EmailChanged(value)),
          decoration: InputDecoration(
            labelText: "Email",
            errorText: state.email.isNotValid ? "Invalid email" : null,
          ),
        );
      },
    );
  }
}