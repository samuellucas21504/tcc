import 'package:formz/formz.dart';

enum EmailConfirmationValidationError {
  empty,
  mismatch,
}

class EmailConfirmation
    extends FormzInput<String, EmailConfirmationValidationError> {
  const EmailConfirmation.pure({required this.email}) : super.pure('');
  const EmailConfirmation.dirty({required this.email, value = ''})
      : super.dirty(value);

  final String email;

  @override
  EmailConfirmationValidationError? validator(String value) {
    if (value.isEmpty) return EmailConfirmationValidationError.empty;
    if (email != value) return EmailConfirmationValidationError.mismatch;

    return null;
  }
}

extension Explanation on EmailConfirmationValidationError {
  String? get name {
    switch (this) {
      case EmailConfirmationValidationError.mismatch:
        return 'Os emails devem ser iguais';
      default:
        return null;
    }
  }
}
