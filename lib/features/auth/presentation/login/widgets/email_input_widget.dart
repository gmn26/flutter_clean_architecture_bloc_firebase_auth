import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_event.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_state.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.email != curr.email,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<LoginBloc>().add(EmailChanged(value)),
          decoration: InputDecoration(
            labelText: "Email",
            errorText: state.email.isNotValid ? "Invalid email" : null,
          ),
        );
      },
    );
  }
}