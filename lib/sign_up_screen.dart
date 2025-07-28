import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('تم التسجيل بنجاح!')));
          } else if (state.status.isInvalid) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('يرجى التأكد من صحة البيانات.')),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _InputField(
                  label: 'Username',
                  onChanged: (v) =>
                      context.read<AuthBloc>().add(UsernameChanged(v)),
                ),
                const SizedBox(height: 10),
                _InputField(
                  label: 'Email',
                  onChanged: (v) =>
                      context.read<AuthBloc>().add(EmailChanged(v)),
                ),
                const SizedBox(height: 10),
                _InputField(
                  label: 'Password',
                  obscure: true,
                  onChanged: (v) =>
                      context.read<AuthBloc>().add(PasswordChanged(v)),
                ),
                const SizedBox(height: 10),
                _InputField(
                  label: 'Confirm Password',
                  obscure: true,
                  onChanged: (v) =>
                      context.read<AuthBloc>().add(ConfirmPasswordChanged(v)),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.status.isSubmissionInProgress
                            ? null
                            : () =>
                                  context.read<AuthBloc>().add(FormSubmitted()),
                        child: state.status.isSubmissionInProgress
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Sign Up'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final bool obscure;
  final Function(String) onChanged;

  const _InputField({
    required this.label,
    required this.onChanged,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
