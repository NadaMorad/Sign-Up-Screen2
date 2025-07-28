import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'email.dart';
import 'password.dart';
import 'username.dart';

class AuthState extends Equatable {
  final Username username;]
  final Email email;
  final Password password;
  final Password confirmPassword;
  final FormzStatus status;

  const AuthState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  AuthState copyWith({
    Username? username,
    Email? email,
    Password? password,
    Password? confirmPassword,
    FormzStatus? status,
  }) {
    return AuthState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [username, email, password, confirmPassword, status];
}
