import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'email.dart';
import 'password.dart';
import 'username.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<UsernameChanged>((event, emit) {
      final username = Username.dirty(event.username);
      emit(
        state.copyWith(
          username: username,
          status: Formz.validate([
            username,
            state.email,
            state.password,
            state.confirmPassword,
          ]),
        ),
      );
    });

    on<EmailChanged>((event, emit) {
      final email = Email.dirty(event.email);
      emit(
        state.copyWith(
          email: email,
          status: Formz.validate([
            state.username,
            email,
            state.password,
            state.confirmPassword,
          ]),
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      final password = Password.dirty(event.password);
      emit(
        state.copyWith(
          password: password,
          status: Formz.validate([
            state.username,
            state.email,
            password,
            state.confirmPassword,
          ]),
        ),
      );
    });

    on<ConfirmPasswordChanged>((event, emit) {
      final confirmPassword = Password.dirty(event.confirmPassword);
      emit(
        state.copyWith(
          confirmPassword: confirmPassword,
          status: Formz.validate([
            state.username,
            state.email,
            state.password,
            confirmPassword,
          ]),
        ),
      );
    });

    on<FormSubmitted>((event, emit) async {
      if (state.status.isValidated &&
          state.password.value == state.confirmPassword.value) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        await Future.delayed(const Duration(seconds: 1));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.invalid));
      }
    });
  }
}
