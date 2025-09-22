import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/register/bloc/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [Text("Form Login")]),
        ),
      ),
    );
  }
}
