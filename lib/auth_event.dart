abstract class AuthEvent {}

class UsernameChanged extends AuthEvent {
  final String username;
  UsernameChanged(this.username);
}

class EmailChanged extends AuthEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends AuthEvent {
  final String password;
  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class FormSubmitted extends AuthEvent {}
