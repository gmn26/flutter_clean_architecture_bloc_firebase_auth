import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/widgets/email_input_widget.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/widgets/login_button_widget.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/widgets/password_input_widget.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/widgets/register_link_widget.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              EmailInput(),
              SizedBox(height: 16),
              PasswordInput(),
              SizedBox(height: 16),
              LoginButton(),
              SizedBox(height: 8),
              RegisterLink(),
            ],
          ),
        ),
      ),
    );
  }
}
