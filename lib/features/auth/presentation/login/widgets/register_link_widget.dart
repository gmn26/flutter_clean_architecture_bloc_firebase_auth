import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_event.dart';
import 'package:flutter_clean_architecture_bloc_firebase_auth/features/auth/presentation/login/bloc/login_state.dart';

class RegisterLink extends StatelessWidget {
  const RegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/register");
      },
      child: const Text("Don't have an account? Register"),
    );
  }
}