import 'package:formz/formz.dart';

enum ReasonValidationError { empty }

class Reason extends FormzInput<String, ReasonValidationError> {
  const Reason.pure() : super.pure('');
  const Reason.dirty([super.value = '']) : super.dirty();

  @override
  ReasonValidationError? validator(String value) {
    if (value.isEmpty) return ReasonValidationError.empty;
    return null;
  }
}
