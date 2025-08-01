import 'package:formz/formz.dart';

enum PasswordValidationError { tooShort }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    return value.length >= 6 ? null : PasswordValidationError.tooShort;
  }
}
